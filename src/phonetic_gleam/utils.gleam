import gleam/list
import gleam/string
import gleam/set

pub fn remove_value(xs: List(a), value: a) {
  list.filter(xs, fn(x) { x != value })
}

pub fn remove_not_allowed_chars(word: String, allowed_chars: String) {
  let allowed_chars_set =
    allowed_chars
    |> string.to_graphemes
    |> set.from_list
  word
  |> string.to_graphemes
  |> list.filter(fn(c) { set.contains(allowed_chars_set, c) })
  |> string.join("")
}

pub fn remove_adjacent_dups(xs: List(a)) -> List(a) {
  list.fold_right(xs, [], fn(acc, x) {
    case list.first(acc) {
      Ok(r) if r == x -> acc
      _ -> [x, ..acc]
    }
  })
}

pub fn then_or_else(is: Bool, then: a, or_else: a) {
  case is {
    True -> then
    False -> or_else
  }
}
