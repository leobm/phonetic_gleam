import gleeunit/should
import phonetic_gleam/metaphone

// implement test case from https://github.com/n7v/phonetic/blob/master/spec/phonetic/metaphone_spec.rb

pub fn should_drop_duplicate_adjacent_letters_except_for_c_test() {
  metaphone.encode("Atticus")
  |> should.equal("ATKS")
  metaphone.encode("Finn")
  |> should.equal("FN")
  metaphone.encode("Dillon")
  |> should.equal("TLN")
}

pub fn should_drop_the_first_letter_if_word_begins_with_kn_gn_pn_ae_wr_test() {
  metaphone.encode("Aeneid")
  |> should.equal("ENT")
  metaphone.encode("Knapp")
  |> should.equal("NP")
  metaphone.encode("Gnome")
  |> should.equal("NM")
  metaphone.encode("Phantom")
  |> should.equal("FNTM")
  metaphone.encode("Wright")
  |> should.equal("RT")
  metaphone.encode("Pneumatic")
  |> should.equal("NMTK")
}

pub fn should_drop_b_if_after_m_at_the_end_of_the_word_test() {
  metaphone.encode("Plumb")
  |> should.equal("PLM")
  metaphone.encode("Amber")
  |> should.equal("AMBR")
}

pub fn should_transform_cia_to_xia_test() {
  metaphone.encode("Ciara")
  |> should.equal("XR")
  metaphone.encode("Phylicia")
  |> should.equal("FLX")
}

pub fn should_transform_ch_to_x_if_it_is_not_the_part_of_a_middle_sch_test() {
  metaphone.encode("Dratch")
  |> should.equal("TRX")
  metaphone.encode("Heche")
  |> should.equal("HX")
  metaphone.encode("Christina")
  |> should.equal("XRSTN")
}

pub fn should_transform_sch_to_skh_test() {
  metaphone.encode("School")
  |> should.equal("SKL")
  metaphone.encode("Deschanel")
  |> should.equal("TSKNL")
}

pub fn should_transform_c_to_s_if_followed_by_i_or_e_or_y_and_to_k_otherwise_test() {
  metaphone.encode("Felicity")
  |> should.equal("FLST")
  metaphone.encode("Joyce")
  |> should.equal("JS")
  metaphone.encode("Nancy")
  |> should.equal("NNS")
  metaphone.encode("Carol")
  |> should.equal("KRL")
  metaphone.encode("C")
  |> should.equal("K")
}

pub fn should_transform_x_to_s_if_at_beginning_otherwise_to_ks_test() {
  metaphone.encode("X")
  |> should.equal("S")
  metaphone.encode("AX")
  |> should.equal("AKS")
}

pub fn should_drop_g_if_followed_by_h_and_h_is_not_at_the_end_or_before_a_vowel_test() {
  metaphone.encode("Knight")
  |> should.equal("NT")
  metaphone.encode("Clayburgh")
  |> should.equal("KLBRK")
  metaphone.encode("Haughton")
  |> should.equal("HTN")
  metaphone.encode("Monaghan")
  |> should.equal("MNKN")
}

pub fn should_transform_g_to_j_if_before_i_or_e_or_y_and_to_k_otherwise_test() {
  metaphone.encode("Gh0")
  |> should.equal("0")
  metaphone.encode("Ghe")
  |> should.equal("K")
  metaphone.encode("Gigi")
  |> should.equal("JJ")
  metaphone.encode("Gena")
  |> should.equal("JN")
  metaphone.encode("Peggy")
  |> should.equal("PK")
  metaphone.encode("Gyllenhaal")
  |> should.equal("JLNHL")
  metaphone.encode("Madigan")
  |> should.equal("MTKN")
  metaphone.encode("G")
  |> should.equal("K")
}

pub fn should_drop_g_if_followed_by_n_or_ned_and_is_at_the_end_test() {
  metaphone.encode("GN")
  |> should.equal("N")
  metaphone.encode("GNE")
  |> should.equal("N")
  metaphone.encode("GNED")
  |> should.equal("NT")
  metaphone.encode("Agnes")
  |> should.equal("ANS")
  metaphone.encode("Signed")
  |> should.equal("SNT")
}

pub fn should_drop_h_if_after_vowel_and_not_before_a_vowel_test() {
  metaphone.encode("Shahi")
  |> should.equal("XH")
  metaphone.encode("Sarah")
  |> should.equal("SR")
  metaphone.encode("Moorehead")
  |> should.equal("MRHT")
  metaphone.encode("Poehler")
  |> should.equal("PLR")
}

pub fn should_transform_ck_to_k_test() {
  metaphone.encode("Ack")
  |> should.equal("AK")
}

pub fn should_transform_ph_to_f_test() {
  metaphone.encode("Sophia")
  |> should.equal("SF")
}

pub fn should_transform_q_to_k_test() {
  metaphone.encode("Quinn")
  |> should.equal("KN")
}

pub fn should_transform_v_to_f_test() {
  metaphone.encode("Victoria")
  |> should.equal("FKTR")
}

pub fn should_transform_z_to_s_test() {
  metaphone.encode("Zelda")
  |> should.equal("SLT")
}

pub fn should_transform_sh_xh_test() {
  metaphone.encode("Ashley")
  |> should.equal("AXL")
}

pub fn should_transform_sio_xio_test() {
  metaphone.encode("Siobhan")
  |> should.equal("XBHN")
}

pub fn should_transform_sia_xia_test() {
  metaphone.encode("Siamese")
  |> should.equal("XMS")
}

pub fn should_transform_tia_xia_test() {
  metaphone.encode("Tia")
  |> should.equal("X")
  metaphone.encode("Portia")
  |> should.equal("PRX")
}

pub fn should_transform_tio_xio_test() {
  metaphone.encode("Interaction")
  |> should.equal("INTRKXN")
}

pub fn should_transform_th_to_0_test() {
  metaphone.encode("Catherine")
  |> should.equal("K0RN")
}

pub fn should_transform_tch_to_ch_test() {
  metaphone.encode("Dratch")
  |> should.equal("TRX")
  metaphone.encode("Fletcher")
  |> should.equal("FLXR")
}

pub fn should_transform_wh_to_w_at_the_beginning_drop_w_if_not_followed_by_a_vowel_test() {
  metaphone.encode("Whoopi")
  |> should.equal("WP")
  metaphone.encode("Goodwin")
  |> should.equal("KTWN")
  metaphone.encode("Harlow")
  |> should.equal("HRL")
  metaphone.encode("Hawley")
  |> should.equal("HL")
}

pub fn should_transform_x_to_s_at_the_beginning_and_x_to_ks_otherwise_test() {
  metaphone.encode("Xor")
  |> should.equal("SR")
  metaphone.encode("Alexis")
  |> should.equal("ALKSS")
  metaphone.encode("X")
  |> should.equal("S")
}

pub fn should_drop_y_if_not_followed_by_a_vowel_test() {
  metaphone.encode("Yasmine")
  |> should.equal("YSMN")
  metaphone.encode("Blonsky")
  |> should.equal("BLNSK")
  metaphone.encode("Blyth")
  |> should.equal("BL0")
}

pub fn should_drop_all_vowels_unless_it_is_the_beginning_test() {
  metaphone.encode("Boardman")
  |> should.equal("BRTMN")
  metaphone.encode("Mary")
  |> should.equal("MR")
  metaphone.encode("Ellen")
  |> should.equal("ELN")
}

pub fn should_transform_d_to_j_if_followed_by_ge_or_gy_or_gi_and_to_t_otherwise_test() {
  metaphone.encode("Coolid")
  |> should.equal("KLT")
  metaphone.encode("Coolidg")
  |> should.equal("KLTK")
  metaphone.encode("Coolidge")
  |> should.equal("KLJ")
  metaphone.encode("Lodgy")
  |> should.equal("LJ")
  metaphone.encode("Pidgin")
  |> should.equal("PJN")
  metaphone.encode("Dixie")
  |> should.equal("TKS")
  metaphone.encode("D")
  |> should.equal("T")
}

pub fn codes_for_known_words_test() {
  metaphone.encode("discrimination")
  |> should.equal("TSKRMNXN")
  metaphone.encode("hello")
  |> should.equal("HL")
  metaphone.encode("droid")
  |> should.equal("TRT")
  metaphone.encode("hypocrite")
  |> should.equal("HPKRT")
  metaphone.encode("well")
  |> should.equal("WL")
  metaphone.encode("am")
  |> should.equal("AM")
  metaphone.encode("say")
  |> should.equal("S")
  metaphone.encode("pheasant")
  |> should.equal("FSNT")
  metaphone.encode("god")
  |> should.equal("KT")
  metaphone.encode("Karen")
  |> should.equal("KRN")
  metaphone.encode("Frank")
  |> should.equal("FRNK")
}
