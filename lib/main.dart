import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'encrypt/caesar.dart';
import 'encrypt/monoalphabetic.dart';
import 'encrypt/playfair.dart';
import 'encrypt/vigenere.dart';

import 'decrypt/caesar.dart';
import 'decrypt/monoalphabetic.dart';
import 'decrypt/playfair.dart';
import 'decrypt/vigenere.dart';

main(List<String> args) {
  runApp(_App());
}

class _App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State {
  TextEditingController _text = TextEditingController();
  TextEditingController _key = TextEditingController();
  TextEditingController _output = TextEditingController();
  var _appTitle = 'Encrypt Text',
      _themeColor = Colors.grey,
      _titleSize = 25.0,
      _sizedBoxWidth = 15.0,
      _sizedBoxHeight = 40.0,
      _txtFieldFontSize = 20.0,
      _txtEnabled = false,
      _keyEnabled = false,
      _keyIconColor = Colors.grey,
      _keyboardType = TextInputType.text;

  AppBar _appBar() {
    return AppBar(
      backgroundColor: _themeColor,
      centerTitle: true,
      title: Text(
        _appTitle,
        style: TextStyle(
          fontSize: _titleSize,
        ),
      ),
    );
  }

  SizedBox _sizedBoxForHeight(bool isForHeight, double size) {
    if (isForHeight == true) {
      return SizedBox(
        height: size,
      );
    } else {
      return SizedBox(
        width: size,
      );
    }
  }

  FloatingActionButton _ciphersBtn(Color bgColor, String lbl, var keyboardType,
      bool isTxtEnabled, bool isKeyEnabled) {
    return FloatingActionButton.extended(
      backgroundColor: bgColor,
      label: Text(
        lbl,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () => setState(() {
        _themeColor = bgColor;
        if (_themeColor == Colors.indigo) {
          _keyIconColor = Colors.grey;
        } else {
          _keyIconColor = _themeColor;
        }
        _keyboardType = keyboardType;
        _txtEnabled = isTxtEnabled;
        _keyEnabled = isKeyEnabled;
        _key.text = '';
        _output.text = '';
        FocusScope.of(context).requestFocus(new FocusNode());
      }),
    );
  }

  TextField _textField(
    var txtFieldController,
    bool isReadOnly,
    bool isEnabled,
    var txtFieldIcon,
    Color iconColor,
    String hintTxt,
    double fntSize,
  ) {
    var printedHintTxt = hintTxt, viewedKeyboard = _keyboardType;
    if (_themeColor == Colors.indigo && txtFieldIcon == Icons.vpn_key) {
      _key.text = '';
      printedHintTxt = alphabet0.join(',');
    } else {
      printedHintTxt = hintTxt;
    }
    if (txtFieldIcon == Icons.text_fields) {
      viewedKeyboard = TextInputType.text;
    } else {
      viewedKeyboard = _keyboardType;
    }
    return TextField(
      controller: txtFieldController,
      readOnly: isReadOnly,
      enabled: isEnabled,
      decoration: InputDecoration(
        hintMaxLines: 100000 * 100000,
        hintText: printedHintTxt,
        hintStyle: TextStyle(
          fontSize: fntSize,
        ),
        icon: Icon(txtFieldIcon, color: iconColor),
      ),
      cursorColor: _themeColor,
      keyboardType: viewedKeyboard,
    );
  }

  FloatingActionButton _encryprDecrypt(Color bgColor, String lbl) {
    return FloatingActionButton.extended(
      backgroundColor: bgColor,
      label: Text(
        lbl,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () => setState(() {
        if (lbl == 'Encrypt') {
          if (lbl == 'Caesar') {
            _output.text = caesar(_text.text, int.parse(_key.text));
          } else if (lbl == 'Monoalphabetic') {
            _output.text = monoAlphabetic(_text.text);
          } else if (lbl == 'PlayFair') {
            _output.text = playFair(_text.text, _key.text);
          } else if (lbl == 'Vigenere') {
            _output.text = vigenere(_text.text, _key.text);
          }
          FocusScope.of(context).requestFocus(new FocusNode());
        } else {
          if (lbl == 'Caesar') {
            _output.text = deCaesar(_text.text, int.parse(_key.text));
          } else if (lbl == 'Monoalphabetic') {
            _output.text = dePlayFair(_text.text, _key.text);
          } else if (lbl == 'PlayFair') {
            _output.text = deVigenere(_text.text, _key.text);
          } else if (lbl == 'Vigenere') {
            _output.text = deMonoAlphabetic(_text.text);
          }
          FocusScope.of(context).requestFocus(new FocusNode());
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ciphersBtn(Colors.blue, 'Caesar', TextInputType.number,
                        true, true),
                    _sizedBoxForHeight(false, _sizedBoxWidth),
                    _ciphersBtn(Colors.indigo, 'Monoalphabetic',
                        TextInputType.text, true, false),
                  ],
                ),
                _sizedBoxForHeight(true, _sizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ciphersBtn(
                        Colors.red, 'PlayFair', TextInputType.text, true, true),
                    _sizedBoxForHeight(false, _sizedBoxWidth),
                    _ciphersBtn(Colors.teal, 'Vigenere', TextInputType.text,
                        true, true),
                  ],
                ),
                _sizedBoxForHeight(true, _sizedBoxHeight),
                Container(
                  child: _textField(
                      _text,
                      false,
                      _txtEnabled,
                      Icons.text_fields,
                      _themeColor,
                      'Text',
                      _txtFieldFontSize),
                ),
                _sizedBoxForHeight(true, _sizedBoxHeight),
                Container(
                  child: _textField(_key, false, _keyEnabled, Icons.vpn_key,
                      _keyIconColor, 'Key', _txtFieldFontSize),
                ),
                _sizedBoxForHeight(true, _sizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _encryprDecrypt(_themeColor, 'Encrypt'),
                    _sizedBoxForHeight(false, _sizedBoxWidth),
                    _encryprDecrypt(_themeColor, 'Decrypt'),
                  ],
                ),
                _sizedBoxForHeight(true, _sizedBoxHeight),
                Container(
                  child: _textField(
                      _output,
                      true,
                      _txtEnabled,
                      Icons.enhanced_encryption,
                      Colors.grey,
                      'Output',
                      _txtFieldFontSize),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
