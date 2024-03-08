import gleam/string
import phonetic_gleam/utils.{then_or_else}

// https://en.wikipedia.org/wiki/New_York_State_Identification_and_Intelligence_System

fn tr_first_chars(word: String) -> String {
  case string.to_graphemes(word) {
    ["M", "A", "C", ..t] -> ["M", "C", ..t]
    ["K", "N", ..t] -> ["N", "N", ..t]
    ["K", ..t] -> ["C", ..t]
    ["P", "H", ..t] -> ["F", "F", ..t]
    ["P", "F", ..t] -> ["F", "F", ..t]
    ["S", "C", "H", ..t] -> ["S", "S", "S", ..t]
    xs -> xs
  }
  |> string.join("")
}

fn tr_last_chars(word: String) -> String {
  let end = string.slice(from: word, at_index: -2, length: 2)
  string.drop_right(from: word, up_to: 2)
  <> case end {
    "EE" | "IE" -> "Y"
    "DT" | "RT" | "RD" | "NT" | "ND" -> "D"
    _ -> end
  }
}

fn tr(chars: List(String), prev: String, code: String) -> String {
  case chars {
    [] -> code
    _ -> {
      let #(next_chars, next_codes) = case chars {
        [] -> #([], "")
        ["E", "V", ..t] -> #(["F", ..t], "AF")
        ["A", ..t] | ["E", ..t] | ["I", ..t] | ["O", ..t] | ["U", ..t] -> #(
          t,
          "A",
        )
        ["Q", ..t] -> #(t, "G")
        ["Z", ..t] -> #(t, "S")
        ["M", ..t] -> #(t, "N")
        ["K", "N", ..t] -> #(t, "N")
        ["K", ..t] -> #(t, "C")
        ["S", "C", "H", ..t] -> #(t, "SSS")
        ["P", "H", ..t] -> #(t, "FF")
        ["H", next, ..t] -> {
          let do_set_to_prev = !is_vowel(prev) || !is_vowel(next)
          then_or_else(do_set_to_prev, #([next, ..t], prev), #([next, ..t], "H"))
        }
        ["H", ..t] -> then_or_else(!is_vowel(prev), #(t, prev), #(t, "H"))
        ["W", ..t] -> then_or_else(is_vowel(prev), #(t, prev), #(t, "W"))
        [x, ..xs] -> #(xs, x)
      }
      tr(next_chars, first_char(next_codes), code <> next_codes)
    }
  }
}

fn drop_last_chars(word: String) -> String {
  let end =
    string.slice(from: word, at_index: -2, length: 2)
    |> string.to_graphemes
  string.drop_right(from: word, up_to: 2)
  <> case end {
    [c, "S"] -> c
    ["A", "Y"] -> "Y"
    [c, "A"] -> c
    chars -> string.join(chars, "")
  }
}

fn first_char(word) {
  case string.pop_grapheme(word) {
    Ok(#(a, _)) -> a
    Error(Nil) -> ""
  }
}

fn is_vowel(c: String) {
  c == "A" || c == "E" || c == "I" || c == "O" || c == "U"
}

fn prepare_word(word: String) -> String {
  word
  |> string.uppercase
  |> utils.remove_not_allowed_chars("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
}

fn cleanup(codes) {
  codes
  |> string.to_graphemes
  |> utils.remove_adjacent_dups
  |> string.join("")
  |> drop_last_chars
}

pub fn encode(word) -> String {
  let name =
    prepare_word(word)
    |> tr_first_chars
    |> tr_last_chars
  {
    first_char(name)
    <> string.drop_left(from: name, up_to: 1)
    |> string.to_graphemes
    |> tr("", "")
  }
  |> cleanup
}
