import 'alphabet.dart';

String deVigenere(String plaintext, String key) {
  String encryptedTxt = "";
  var pos = new List();
  var poss = new List();
  for (int i = 0; i < plaintext.length; i++) {
    pos.add(alphabet.indexOf(plaintext[i]));
  }
  for (int i = 0; i < key.length; i++) {
    poss.add(alphabet.indexOf(key[i]));
  }
  OUTER:
  for (int i = 0; i < plaintext.length;) {
    int k = 0;
    for (int j = 0; j < key.length;) {
      if (i < plaintext.length) {
        k = ((pos[i] + poss[j]) % 62);
        if (plaintext[i] == ' ') {
          encryptedTxt = encryptedTxt + ' ';
        } else {
          encryptedTxt = encryptedTxt + "${alphabet[k]}";
        }
        j = j + 1;
        i++;
      } else {
        break OUTER;
      }
    }
  }
  return (encryptedTxt);
}
