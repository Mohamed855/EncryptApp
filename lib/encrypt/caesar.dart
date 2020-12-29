import 'alphabet.dart';

String caesar(String plaintext, int key) {
  String encryptedTxt = "";
  for (int i = 0; i < plaintext.length; i++) {
    int k = (alphabet.indexOf(plaintext[i]) + key) % 62;
    if (plaintext[i] == ' ') {
      encryptedTxt = encryptedTxt + ' ';
    } else {
      encryptedTxt = encryptedTxt + "${alphabet[k]}";
    }
  }
  return encryptedTxt;
}
