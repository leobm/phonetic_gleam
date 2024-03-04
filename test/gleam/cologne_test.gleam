import gleeunit/should
import gleam/phonetic/cologne

// A, E, I, J, O, U, Y must become 0

pub fn a_should_become_0_test() {
  cologne.encode("a")
  |> should.equal("0")
}

pub fn i_should_become_0_test() {
  cologne.encode("i")
  |> should.equal("0")
}

pub fn j_should_become_0_test() {
  cologne.encode("j")
  |> should.equal("0")
}

pub fn o_should_become_0_test() {
  cologne.encode("o")
  |> should.equal("0")
}

pub fn u_should_become_0_test() {
  cologne.encode("u")
  |> should.equal("0")
}

pub fn y_should_become_0_test() {
  cologne.encode("y")
  |> should.equal("0")
}

// H must become empty

pub fn h_should_become_empty_test() {
  cologne.encode("h")
  |> should.equal("")
}

// B, P must become 1

pub fn b_should_become_1_test() {
  cologne.encode("b")
  |> should.equal("1")
}

pub fn p_should_become_1_test() {
  cologne.encode("p")
  |> should.equal("1")
}

pub fn p_should_become_3_when_before_h_test() {
  cologne.encode("ph")
  |> should.equal("3")
}

// D, T must become 2 when not before C, S, Z
pub fn d_should_become_2_when_not_before_c_s_z_test() {
  cologne.encode("d")
  |> should.equal("2")
}

pub fn t_should_become_2_when_not_before_c_s_z_test() {
  cologne.encode("t")
  |> should.equal("2")
}

// "F, V, W must become 3

pub fn f_should_become_3_test() {
  cologne.encode("f")
  |> should.equal("3")
}

pub fn v_should_become_3_test() {
  cologne.encode("v")
  |> should.equal("3")
}

pub fn w_should_become_3_test() {
  cologne.encode("w")
  |> should.equal("3")
}

// G, K, Q must become 4

pub fn g_should_become_4_test() {
  cologne.encode("g")
  |> should.equal("4")
}

pub fn k_should_become_4_test() {
  cologne.encode("k")
  |> should.equal("4")
}

pub fn q_should_become_4_test() {
  cologne.encode("q")
  |> should.equal("4")
}

// C must become 4 when C is the initial sound before A, H, K, L, O, Q, R, U, X

pub fn c_should_become_4_when_c_is_the_initial_sound_before_a_test() {
  cologne.encode("ca")
  |> should.equal("4")
}

pub fn c_should_become_4_when_c_is_the_initial_sound_before_h_test() {
  cologne.encode("ch")
  |> should.equal("4")
}

pub fn c_should_become_4_when_c_is_the_initial_sound_before_k_test() {
  cologne.encode("ck")
  |> should.equal("4")
}

pub fn c_should_become_4_when_c_is_the_initial_sound_before_o_test() {
  cologne.encode("co")
  |> should.equal("4")
}

pub fn c_should_become_4_when_c_is_the_initial_sound_before_q_test() {
  cologne.encode("cq")
  |> should.equal("4")
}

pub fn c_should_become_4_when_c_is_the_initial_sound_before_u_test() {
  cologne.encode("cu")
  |> should.equal("4")
}

pub fn c_should_become_45_when_c_is_the_initial_sound_before_l_test() {
  cologne.encode("cl")
  |> should.equal("45")
}

pub fn c_should_become_47_when_c_is_the_initial_sound_before_r_test() {
  cologne.encode("cr")
  |> should.equal("47")
}

pub fn c_should_become_48_when_c_is_the_initial_sound_before_x_test() {
  cologne.encode("cx")
  |> should.equal("48")
}

pub fn codes_for_known_words_test() {
  cologne.encode("Wikipedia")
  |> should.equal("3412")
  cologne.encode("Müller-Lüdenscheidt")
  |> should.equal("65752682")
  cologne.encode("Breschnew")
  |> should.equal("17863")
  cologne.encode("Müller")
  |> should.equal("657")
  cologne.encode("schmidt")
  |> should.equal("862")
  cologne.encode("schneider")
  |> should.equal("8627")
  cologne.encode("fischer")
  |> should.equal("387")
  cologne.encode("Philip")
  |> should.equal("351")
  cologne.encode("Patrick")
  |> should.equal("1274")
  cologne.encode("weber")
  |> should.equal("317")
  cologne.encode("meyer")
  |> should.equal("67")
  cologne.encode("wagner")
  |> should.equal("3467")
  cologne.encode("schulz")
  |> should.equal("858")
  cologne.encode("becker")
  |> should.equal("147")
  cologne.encode("hoffmann")
  |> should.equal("0366")
  cologne.encode("schäfer")
  |> should.equal("837")
  cologne.encode("cater")
  |> should.equal("427")
  cologne.encode("axel")
  |> should.equal("0485")
  cologne.encode("Xavier")
  |> should.equal("4837")
  cologne.encode("Christopher")
  |> should.equal("478237")
  cologne.encode("Wilhelm")
  |> should.equal("3556")
}
