import gleam/string
import gleam/list
import gleam/result

// https://en.wikipedia.org/wiki/Metaphone
// https://gist.github.com/Rostepher/b688f709587ac145a0b3

fn tr(chars: List(String), recent: String, codes: List(String)) -> List(String) {
  case chars {
    [] -> list.reverse(codes)
    _ -> {
      let last_code = result.unwrap(list.first(codes), "")
      let is_first = last_code == ""
      let is_not_first = !is_first
      let #(a, b, c, d, t) = characters_and_rest(chars)
      let drop_first = fn() { #([b, c, d, ..t], codes) }
      let tr_first_two_to_code = fn(code) { #([c, d, ..t], [code, ..codes]) }
      let tr_first_to_code = fn(code) { #([b, c, d, ..t], [code, ..codes]) }
      let tr_first_to_two_codes = fn(code1, code2) {
        #([b, c, d, ..t], [code2, code1, ..codes])
      }
      let tr_first_and_second_to = fn(code) { #([c, d, ..t], [code, ..codes]) }

      let #(chars, codes) = case a {
        "" -> #([], codes)
        // 1. Drop duplicate adjacent letters, except for C
        a if a == b && a != "c" -> drop_first()

        // 2. Drop the first letter if the string begins with AE, GN, KN, PN or WR
        "a" if b == "e" -> drop_first()
        "g" if b == "n" -> drop_first()
        "k" if b == "n" -> drop_first()
        "p" if b == "n" -> drop_first()
        "w" if b == "r" -> drop_first()

        // 3. Drop B if after M at the end of the string
        "b" if recent == "m" && c == "" -> drop_first()

        // 4. 'C' transforms to 'X' if followed by 'IA' or 'H' 
        // (unless in latter case, it is part of '-SCH-', in which case it transforms to 'K'). 
        "c" if b == "i" && c == "a" || b == "h" && recent != "s" ->
          tr_first_to_code("X")
        // 4.1 'C' transforms to 'S' if followed by 'I', 'E', or 'Y'. 
        "c" if b == "i" || b == "e" || b == "y" -> tr_first_to_code("S")
        // 4.2 Otherwise, 'C' transforms to 'K'.
        "c" -> tr_first_to_code("K")

        // 5. 'D' transforms to 'J' if followed by 'GE', 'GY', or 'GI'. 
        "d" if b == "g" && c == "e" -> tr_first_two_to_code("J")
        "d" if b == "g" && c == "y" -> tr_first_two_to_code("J")
        "d" if b == "g" && c == "i" -> tr_first_two_to_code("J")
        // 5.1 Otherwise, 'D' transforms to 'T'.
        "d" -> tr_first_to_code("T")

        // 6. Drop 'G' if followed by 'H' and 'H' is not at the end or before a vowel.
        "g" if b == "h"
          && {
            c != ""
            && c != "a"
            && c != "e"
            && c != "i"
            && c != "o"
            && c != "u"
          } -> drop_first()
        // 6.1 Drop 'G' if followed by 'N' or 'NED' and is at the end.
        "g" if b == "n" && c == "e" && d == "d" && t == [] -> drop_first()
        "g" if b == "n" -> drop_first()

        // 7. 'G' transforms to 'J' if before 'I', 'E', or 'Y', (and it is not in 'GG'). 
        "g" if recent != "g" && { b == "i" || b == "e" || b == "y" } ->
          tr_first_to_code("J")
        // 7.1  Otherwise, 'G' transforms to 'K'.
        "g" -> tr_first_to_code("K")

        // 8. Drop 'H' if after vowel and not before a vowel.
        "h" if {
            recent == "a"
            || recent == "e"
            || recent == "i"
            || recent == "o"
            || recent == "u"
          }
          && { b != "a" && b != "e" && b != "i" && b != "o" && b != "u" } ->
          drop_first()

        // 8.1 Drop 'H' if after C, S, P, T or G
        "h" if recent == "c"
          || recent == "s"
          || recent == "p"
          || recent == "t"
          || recent == "g" -> drop_first()

        // 9. Drop K if after C
        "k" if recent == "c" -> drop_first()

        // 10. 'PH' transforms to 'F'.
        "p" if b == "h" -> tr_first_and_second_to("F")

        // 11. 'Q' transforms to 'K'.
        "q" -> tr_first_to_code("K")

        // 12. S' transforms to 'X' if followed by 'H', 'IO', or 'IA'.
        "s" if b == "h" || b == "i" && c == "o" || b == "i" && c == "a" ->
          tr_first_to_code("X")

        // 13. 'T' transforms to 'X' if followed by 'IA' or 'IO'. 
        "t" if b == "i" && c == "a" || b == "i" && c == "o" ->
          tr_first_to_code("X")
        // 14. 'TH' transforms to '0'. 
        "t" if b == "h" -> tr_first_and_second_to("0")

        // 15. Drop 'T' if followed by 'CH'.
        "t" if b == "c" && c == "h" -> drop_first()

        // 16. V' transforms to 'F'.
        "v" -> tr_first_to_code("F")

        // 17. 'WH' transforms to 'W' if at the beginning. 
        "w" if b == "h" && is_first -> tr_first_and_second_to("W")

        // 18. Drop W if not followed by a vowel
        "w" if b != "a" && b != "e" && b != "i" && b != "o" && b != "u" ->
          drop_first()

        // 19. 'X' transforms to 'S' if at the beginning. 
        "x" if is_first -> tr_first_to_code("S")
        // 19.1 Otherwise, 'X' transforms to 'KS'.
        "x" -> tr_first_to_two_codes("K", "S")

        // 20. Drop 'Y' if not followed by a vowel.
        "y" if b != "a" && b != "e" && b != "i" && b != "o" && b != "u" ->
          drop_first()

        // 21. 'Z' transforms to 'S'.
        "z" -> tr_first_to_code("S")

        // 22. Drop all vowels unless it is the beginning.
        "a" | "e" | "i" | "o" | "u" if is_not_first -> drop_first()

        _ -> tr_first_to_code(a)
      }
      tr(chars, a, codes)
    }
  }
}

fn characters_and_rest(chars: List(String)) {
  case chars {
    [] -> #("", "", "", "", [])
    [a] -> #(a, "", "", "", [])
    [a, b] -> #(a, b, "", "", [])
    [a, b, c] -> #(a, b, c, "", [])
    [a, b, c, d] -> #(a, b, c, d, [])
    [a, b, c, d, ..t] -> #(a, b, c, d, t)
  }
}

fn prepare_word(word: String) -> List(String) {
  word
  |> string.lowercase
  |> string.to_graphemes
}

pub fn encode(word) -> String {
  word
  |> prepare_word
  |> tr("", [])
  |> string.join("")
  |> string.uppercase
}
