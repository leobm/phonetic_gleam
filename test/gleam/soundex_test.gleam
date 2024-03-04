import gleeunit/should
import gleam/phonetic/soundex

pub fn codes_for_known_words_test() {
  soundex.encode("Britney")
  |> should.equal("B635")
  soundex.encode("bewährten")
  |> should.equal("B635")
  soundex.encode("Spears")
  |> should.equal("S162")
  soundex.encode("Superzicke")
  |> should.equal("S16222")
}
