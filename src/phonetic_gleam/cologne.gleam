import gleam/int
import gleam/string
import gleam/list
import phonetic_gleam/utils.{then_or_else}

// https://en.wikipedia.org/wiki/Cologne_phonetics

fn first_second_rest(word) {
  case string.pop_grapheme(word) {
    Ok(#(a, t)) ->
      case string.first(t) {
        Ok(b) -> [a, b, t]
        Error(Nil) -> [a, "", ""]
      }
    Error(Nil) -> ["", "", ""]
  }
}

fn includes_char(s, c) {
  string.to_graphemes(s)
  |> list.any(fn(x) { x == c })
}

fn prepare_word(word) {
  string.uppercase(word)
  |> string.replace(each: "Ä", with: "A")
  |> string.replace(each: "Ö", with: "O")
  |> string.replace(each: "Ü", with: "U")
  |> string.replace(each: "ß", with: "S")
}

fn remove_zeros(codes) {
  // delete all '0' characters, except at the beginning.
  codes
  |> list.index_fold([], fn(acc, code, index) {
    { code == 0 && index != 0 }
    |> then_or_else(acc, [code, ..acc])
  })
}

fn join_codes(codes: List(Int)) -> String {
  codes
  |> list.map(int.to_string)
  |> string.join("")
}

fn tr(word, recent_char, codes) -> List(Int) {
  case word {
    "" -> list.reverse(codes)
    _ -> {
      let assert [a, b, t] = first_second_rest(word)
      let is_before = fn(c) { c == b }
      let is_first = fn() { list.is_empty(codes) }
      let is_before_any = fn(s) { includes_char(s, b) }
      let is_not_after_any = fn(s) { !includes_char(s, recent_char) }
      let is_after_any = fn(s) { includes_char(s, recent_char) }
      let is_first_and_before_any = fn(s) { is_first() && is_before_any(s) }
      let is_before_any_and_not_after_any = fn(s1, s2) {
        is_before_any(s1) && is_not_after_any(s2)
      }
      let code = case a {
        "A" | "E" | "I" | "J" | "O" | "U" | "Y" -> 0
        "B" -> 1
        "P" ->
          is_before("H")
          |> then_or_else(3, 1)
        "D" | "T" ->
          is_before_any("CSZ")
          |> then_or_else(8, 2)
        "F" | "V" | "W" -> 3
        "G" | "K" | "Q" -> 4
        "C" ->
          {
            is_first_and_before_any("AHKLOQRUX")
            || is_before_any_and_not_after_any("AHKOQUX", "SZ")
          }
          |> then_or_else(4, 8)
        "X" ->
          is_after_any("CKQ")
          |> then_or_else(8, 48)
        "L" -> 5
        "M" | "N" -> 6
        "R" -> 7
        "S" | "Z" | "ß" -> 8
        _ -> -1
      }
      tr(t, a, [code, ..codes])
    }
  }
}

pub fn encode(word) -> String {
  word
  |> prepare_word
  |> tr("", [])
  |> utils.remove_value(-1)
  |> utils.remove_adjacent_dups
  |> remove_zeros
  |> list.reverse
  |> join_codes
}
