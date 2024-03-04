import gleam/list
import gleam/string

fn tr(chars, acc) {
  case chars {
    [] -> list.reverse(acc)
    [a, ..xs] if acc == [] -> tr(xs, [a, ..acc])
    [a, ..xs] ->
      case a {
        "B" | "F" | "P" | "V" -> tr(xs, ["1", ..acc])
        "C" | "G" | "J" | "K" | "Q" | "S" | "X" | "Z" -> tr(xs, ["2", ..acc])
        "D" | "T" -> tr(xs, ["3", ..acc])
        "L" -> tr(xs, ["4", ..acc])
        "M" | "N" -> tr(xs, ["5", ..acc])
        "R" -> tr(xs, ["6", ..acc])
        _ -> tr(xs, acc)
      }
  }
}

fn prepare_word(word) {
  word
  |> string.uppercase
  |> string.to_graphemes
}

pub fn encode(word) {
  word
  |> prepare_word
  |> tr([])
  |> string.join("")
}
