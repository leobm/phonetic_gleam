import gleeunit/should
import phonetic_gleam/utils

pub fn remove_adjacents_dup() {
  utils.remove_adjacent_dups([])
  |> should.equal([])
  utils.remove_adjacent_dups([1])
  |> should.equal([1])
  utils.remove_adjacent_dups([1, 1])
  |> should.equal([1])
  utils.remove_adjacent_dups([1, 2, 3])
  |> should.equal([1, 2, 3])
  utils.remove_adjacent_dups([1, 2, 2, 3, 3, 4])
  |> should.equal([1, 2, 3, 4])
  utils.remove_adjacent_dups([1, 1, 2, 1, 1])
  |> should.equal([1, 2, 1])
}
