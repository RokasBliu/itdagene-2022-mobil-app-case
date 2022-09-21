import 'package:flutter/material.dart';
import 'package:itverket_itdagene_flutter/domain/key.dart';

import '../utils/names.dart';
import 'input.dart';
import 'keyboard.dart';
import 'result.dart';

class Inner extends StatefulWidget {
  final String target;
  final Function callback;

  const Inner(this.target, this.callback, {Key? key}) : super(key: key);

  @override
  State<Inner> createState() => _InnerState();
}

class _InnerState extends State<Inner> {
  static const int maxLength = 11;
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
    false,
    false,
  ];
  Set<String> usedLetters = {};
  Set<String> partialLetters = {};
  Set<String> foundLetters = {};

  int turns = 0;
  bool finished = false;

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

  void enter() async {
    if (!validNames.contains(stuff.join(""))) {
      return;
    }

    setState(() {
      finished = stuff.join("") == target.join("");
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

    if (finished) {
      await _showDialog();
    }

  }

  @override
  Widget build(BuildContext context) {
    target = widget.target.split("").toList();
    var result = Column(
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
    );

    return result;
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
