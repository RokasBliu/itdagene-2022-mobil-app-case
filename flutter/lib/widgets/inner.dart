import 'package:flutter/material.dart';
import 'package:itverket_itdagene_flutter/domain/key.dart';

import 'input.dart';
import 'keyboard.dart';
import 'result.dart';

class Inner extends StatefulWidget {
  final String target;

  const Inner(this.target, {Key? key}) : super(key: key);

  @override
  State<Inner> createState() => _InnerState();
}

class _InnerState extends State<Inner> {
  static const int maxLength = 10;
  List<String> target = [];
  List<String> stuff = [];
  List<bool> found = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  Set<String> usedLetters = {};
  Set<String> partialLetters = {};
  Set<String> foundLetters = {};

  void letter(String m) {
    setState(() {
      if (stuff.length < maxLength) {
        stuff.add(m);
      }
    });
  }

  void backspace() {
    setState(() {
      if (stuff.isNotEmpty) stuff.removeLast();
    });
  }

  void enter() {
    setState(() {
      usedLetters.addAll(stuff);
      partialLetters.addAll(stuff.where((l) => target.contains(l)));
      stuff.asMap().forEach(
            (i, l) => {
              if (i < target.length && target.elementAt(i) == l)
                {foundLetters.add(l), found[i] = true}
            },
          );
      stuff.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    target = widget.target.split("").toList();
    return FittedBox(
      fit: BoxFit.fill,
      child: Column(
        children: [
          Result(target, found),
          Input(stuff),
          Align(
            alignment: Alignment.bottomCenter,
            child: Keyboard((k) {
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
          ),
        ],
      ),
    );
  }
}
