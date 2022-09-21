import 'package:flutter/material.dart';
import 'package:itverket_itdagene_flutter/domain/key.dart';

import 'input.dart';
import 'keyboard.dart';

class Inner extends StatefulWidget {
  const Inner({Key? key}) : super(key: key);

  @override
  State<Inner> createState() => _InnerState();
}

class _InnerState extends State<Inner> {
  List<String> stuff = [];
  Set<String> usedLetters = {};
  Set<String> partialLetters = {};
  Set<String> foundLetters = {};

  void letter(String m) {
    setState(() {
      stuff.add(m);
    });
  }

  void backspace() {
    setState(() {
      stuff.removeLast();
    });
  }

  void enter() {
    setState(() {
      usedLetters.addAll(stuff);
      stuff.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(stuff),
        Keyboard((k) {
          switch (k.type) {
            case KeyType.enter:
              enter();
              break;
            case KeyType.backspace:
              backspace();
              break;
            case KeyType.letter:
              letter(k.semantic);
              break;
          }
        }, usedLetters, partialLetters, foundLetters),
      ],
    );
  }
}
