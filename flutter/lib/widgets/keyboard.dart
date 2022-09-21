import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  static const List<String> _layout = [
    "QWERTYUIOPÅ",
    "ASDFGHJKLØÆ",
    "⌫ZXCVBNM-⏎"
  ];

  final Function callback;

  const Keyboard(this.callback, {Key? key}) : super(key: key);

  Widget _buildKey(BuildContext context, String letter) {
    return Semantics(
      label: letter,
      keyboardKey: true,
      child: GestureDetector(
        onTap: () {
          callback(letter);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 11,
          height: 48,
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
                color: Colors.grey.shade800,
              ),
              child: ExcludeSemantics(
                excluding: true,
                child: Text(
                  letter,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          row.split("").map((letter) => _buildKey(context, letter)).toList(),
    );
  }

  Widget _buildKeyboard(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        children: _layout.map((row) => _buildRow(context, row)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildKeyboard(context);
  }
}
