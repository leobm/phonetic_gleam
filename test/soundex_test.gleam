import gleeunit/should
import phonetic_gleam/soundex

// Implemented based on tests from the implemented Apache commons codec project.
pub fn codes_basic_test() {
  soundex.encode("testing")
  |> should.equal("T235")
  soundex.encode("The")
  |> should.equal("T000")
  soundex.encode("quick")
  |> should.equal("Q200")
  soundex.encode("brown")
  |> should.equal("B650")
  soundex.encode("fox")
  |> should.equal("F200")
  soundex.encode("jumped")
  |> should.equal("J513")
  soundex.encode("over")
  |> should.equal("O160")
  soundex.encode("the")
  |> should.equal("T000")
  soundex.encode("lazy")
  |> should.equal("L200")
  soundex.encode("dogs")
  |> should.equal("D200")
}

// Implemented based on tests from the implemented Apache commons codec project.
// Examples from http://www.bradandkathy.com/genealogy/overviewofsoundex.html
pub fn codes_bradandkathy_examples_test() {
  soundex.encode("Allricht")
  |> should.equal("A462")
  soundex.encode("Eberhard")
  |> should.equal("E166")
  soundex.encode("Engebrethson")
  |> should.equal("E521")
  soundex.encode("Heimbach")
  |> should.equal("H512")
  soundex.encode("Hanselmann")
  |> should.equal("H524")
  soundex.encode("Hildebrand")
  |> should.equal("H431")
  soundex.encode("Kavanagh")
  |> should.equal("K152")
  soundex.encode("Lind")
  |> should.equal("L530")
  soundex.encode("Lukaschowsky")
  |> should.equal("L222")
  soundex.encode("McDonnell")
  |> should.equal("M235")
  soundex.encode("McGee")
  |> should.equal("M200")
  soundex.encode("Opnian")
  |> should.equal("O155")
  soundex.encode("Oppenheimer")
  |> should.equal("O155")
  soundex.encode("Riedemanas")
  |> should.equal("R355")
  soundex.encode("Zita")
  |> should.equal("Z300")
  soundex.encode("Zitzmeinn")
  |> should.equal("Z325")
}

// Examples from http://www.archives.gov/research_room/genealogy/census/soundex.html
pub fn codes_census_examples_test() {
  soundex.encode("Washington")
  |> should.equal("W252")
  soundex.encode("Lee")
  |> should.equal("L000")
  soundex.encode("Gutierrez")
  |> should.equal("G362")
  soundex.encode("Pfister")
  |> should.equal("P236")
  soundex.encode("Jackson")
  |> should.equal("J250")
  soundex.encode("Tymczak")
  |> should.equal("T522")
}

// Examples from http://www.myatt.demon.co.uk/sxalg.htm
pub fn codes_myatt_examples_test() {
  soundex.encode("HOLMES")
  |> should.equal("H452")
  soundex.encode("ADOMOMI")
  |> should.equal("A355")
  soundex.encode("VONDERLEHR")
  |> should.equal("V536")
  soundex.encode("BALL")
  |> should.equal("B400")
  soundex.encode("SHAW")
  |> should.equal("S000")
  soundex.encode("JACKSON")
  |> should.equal("J250")
  soundex.encode("SCANLON")
  |> should.equal("S545")
  soundex.encode("SAINTJOHN")
  |> should.equal("S532")
}

pub fn codes_for_known_words_test() {
  soundex.encode("Britney")
  |> should.equal("B635")
  soundex.encode("bewährten")
  |> should.equal("B635")
  soundex.encode("Spears")
  |> should.equal("S162")
  soundex.encode("Superzicke")
  |> should.equal("S162")
  soundex.encode("'OBrien")
  |> should.equal("O165")
}
