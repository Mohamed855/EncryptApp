import 'alphabet.dart';

var alphabet0 = [
  "6",
  "k",
  "M",
  "t",
  "J",
  "Q",
  "l",
  "W",
  "z",
  "G",
  "0",
  "m",
  "Z",
  "x",
  "P",
  "n",
  "D",
  "u",
  "3",
  "I",
  "o",
  "S",
  "f",
  "p",
  "c",
  "4",
  "B",
  "8",
  "e",
  "g",
  "R",
  "5",
  "i",
  "Y",
  "V",
  "a",
  "w",
  "K",
  "v",
  "N",
  "1",
  "E",
  "A",
  "y",
  "X",
  "H",
  "b",
  "9",
  "h",
  "L",
  "2",
  "r",
  "T",
  "C",
  "q",
  "F",
  "j",
  "s",
  "O",
  "7",
  "d",
  "U"
];

String monoAlphabetic(String plaintext) {
  String encryptedTxt = "";

  for (int i = 0; i < plaintext.length; i++) {
    int k = (alphabet.indexOf(plaintext[i]));
    if (plaintext[i] == ' ') {
      encryptedTxt = encryptedTxt + ' ';
    } else {
      encryptedTxt = encryptedTxt + alphabet0[k];
    }
  }
  return (encryptedTxt);
}
