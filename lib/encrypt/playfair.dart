import 'dart:math';

List<List> data0;
String playFair(String inn0, String keyString) {
  String alphabet = keyString + "abcdefghiklmnopqrstuvwxyz";
  List playfairTable = List.generate(5, (i) => List(5));
  Set numberSet = new Set();
  for (int i = 0; i < alphabet.length; i++) {
    numberSet.add(alphabet[i]);
  }
  int k = 0;
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      playfairTable[i][j] = numberSet.elementAt(k);
      k++;
    }
  }
  int length = 0;
  //String inn0 = "meet me after the party";
  String inn = inn0.replaceAll(" ", "");

  length = (inn.length / 2 + inn.length % 2).toInt();

  var digraph = new List(length); // creates an empty array of length 5
  for (int j = 0; j < length; j++) {
    if (j == (length - 1) && (inn.length / 2).toInt() == (length - 1)) {
      inn = inn + "x";
    }
    digraph[j] = inn[2 * j] + "" + inn[2 * j + 1];
  }
  var out = "";
  var encDigraphs = encodeDigraph(digraph, length, playfairTable);
  for (var i in encDigraphs) {
    out = out + "$i";
  }
  return (out);
}

encodeDigraph(var di, int length, var table) {
  var enc = new List(length);
  for (int i = 0; i < length; i++) {
    var a = di[i][0];
    var b = di[i][1];
    int r1 = getPoint(a, table).x.toInt();
    int r2 = getPoint(b, table).x.toInt();
    int c1 = getPoint(a, table).y.toInt();
    int c2 = getPoint(b, table).y.toInt();

    if (r1 == r2) {
      c1 = (c1 + 1) % 5;
      c2 = (c2 + 1) % 5;
    } else if (c1 == c2) {
      r1 = (r1 + 1) % 5;
      r2 = (r2 + 1) % 5;
    } else {
      int temp = c1;
      c1 = c2;
      c2 = temp;
    }

    enc[i] = table[r1][c1] + "" + table[r2][c2];
  }
  return enc;
}

Point getPoint(String c, var table) {
  Point pt = new Point(0, 0);
  for (int i = 0; i < 5; i++)
    for (int j = 0; j < 5; j++) if (c == table[i][j][0]) pt = new Point(i, j);
  return pt;
}
