import gleam/list
import gleam/string
import phonetic_gleam/utils

fn tr_char(b) {
  case b {
    "B" | "F" | "P" | "V" -> "1"
    "C" | "G" | "J" | "K" | "Q" | "S" | "X" | "Z" -> "2"
    "D" | "T" -> "3"
    "L" -> "4"
    "M" | "N" -> "5"
    "R" -> "6"
    _ -> ""
  }
}

fn tr(chars, acc) {
  case chars {
    [] -> list.reverse(acc)
    [a, b, ..xs] if acc == [] -> {
      // first character code equal with second?
      case tr_char(a) == tr_char(b) {
        True -> tr(xs, [a, ..acc])
        False -> tr([b, ..xs], [a, ..acc])
      }
    }
    [a, ..xs] if acc == [] -> tr(xs, [a, ..acc])
    [a, ..xs] -> tr(xs, [tr_char(a), ..acc])
  }
}

fn cleanup(codes) {
  codes
  |> utils.remove_adjacent_dups
  |> utils.remove_value("")
  |> list.take(4)
  |> string.join("")
  |> string.pad_right(to: 4, with: "0")
}

fn prepare_word(word) {
  word
  |> string.uppercase
  |> utils.remove_not_allowed_chars("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  |> string.to_graphemes
}

pub fn encode(word) {
  word
  |> prepare_word
  |> tr([])
  |> cleanup
}
