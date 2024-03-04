import gleam/io
import gleam/phonetic/nysiis

pub fn main() {
  io.println(nysiis.encode("Bishop"))
  io.println(nysiis.encode("Carlson"))
  io.println(nysiis.encode("Carr"))
  io.println(nysiis.encode("Chapman"))
}
