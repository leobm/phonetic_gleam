import gleam/string
import gleam/list
import gleam/set

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

fn remove_duplicates(word: String) -> String {
  string.to_graphemes(word)
  |> list.fold_right([], fn(acc, code) {
    let last_code = case list.first(acc) {
      Ok(c) -> c
      Error(Nil) -> ""
    }
    { code == "" || last_code == code }
    |> then_or_else(acc, [code, ..acc])
  })
  |> string.join("")
}

fn then_or_else(is, then, or_else) {
  case is {
    True -> then
    False -> or_else
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
  let allowed_chars =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    |> string.to_graphemes
    |> set.from_list

  string.uppercase(word)
  |> string.to_graphemes
  |> list.filter(fn(c) { set.contains(allowed_chars, c) })
  |> string.join("")
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
  |> remove_duplicates
  |> drop_last_chars
}
