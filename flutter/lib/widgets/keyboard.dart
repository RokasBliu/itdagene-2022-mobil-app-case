import 'package:flutter/material.dart';
import 'package:itverket_itdagene_flutter/domain/key.dart';

class Keyboard extends StatelessWidget {
  static const List<String> _letters = [
    "QWERTYUIOPÅ",
    "ASDFGHJKLØÆ",
    "ZXCVBNM-"
  ];

  final Function callback;

  final Set<String> usedLetters;
  final Set<String> partialLetters;
  final Set<String> foundLetters;

  const Keyboard(
      this.callback, this.usedLetters, this.partialLetters, this.foundLetters,
      {Key? key})
      : super(key: key);

  Color _keyColor(KeyboardKey kbKey) {
    switch (kbKey.type) {
      case KeyType.enter:
        return Colors.blue;
      case KeyType.backspace:
        return Colors.red;
      case KeyType.letter:
        if (foundLetters.contains(kbKey.semantic)) {
          return Colors.green;
        } else if (partialLetters.contains(kbKey.semantic)) {
          return Colors.orange;
        } else if (usedLetters.contains(kbKey.semantic)) {
          return Colors.grey.shade800;
        } else {
          return Colors.grey.shade500;
        }
    }
  }

  Widget _buildKey(double width, KeyboardKey kbKey) {
    return Semantics(
      label: kbKey.symbol,
      keyboardKey: true,
      child: GestureDetector(
        onTap: () {
          callback(kbKey);
        },
        child: SizedBox(
          width: width,
          height: 45,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade500,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                color: _keyColor(kbKey),
              ),
              child: ExcludeSemantics(
                excluding: true,
                child: Text(
                  kbKey.symbol,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<Widget> row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: row,
    );
  }

  Widget _buildKeyboard(BuildContext context, List<List<Widget>> layout) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        children: layout.map((row) => _buildRow(context, row)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> layout = _letters
        .map((row) => row
            .split("")
            .map((l) => _buildKey(MediaQuery.of(context).size.width / 11,
                KeyboardKey(l, l, KeyType.letter)))
            .toList())
        .toList(growable: true);

    layout[2].add(_buildKey(1.5 * MediaQuery.of(context).size.width / 11,
        const KeyboardKey("⌫", "backspace", KeyType.backspace)));

    layout[2].add(_buildKey(1.5 * MediaQuery.of(context).size.width / 11,
        const KeyboardKey("⏎", "enter", KeyType.enter)));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildKeyboard(context, layout),
    );
  }
}
