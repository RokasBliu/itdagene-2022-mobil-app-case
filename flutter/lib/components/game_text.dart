import 'package:flutter/cupertino.dart';
import 'dart:ui';

const successColor = Color.fromRGBO(75, 181, 67, 1.0);
const characterStyle = TextStyle(
    letterSpacing: 5.0,
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    color: successColor,
    fontFeatures: [FontFeature.tabularFigures()]);

class GameText extends StatelessWidget {
  final String finalName;
  final Set<String> guessedNames;

  const GameText(this.finalName, this.guessedNames, {Key? key})
      : super(key: key);

  Set<int> foundIndexes() {
    Set<int> foundIndexes = {};
    outer:
    for (var i = 0; i < finalName.length; i++) {
      var guessedNamesIter = guessedNames.iterator;
      while (guessedNamesIter.moveNext()) {
        var curGuessedName = guessedNamesIter.current;
        var curGuessedNameMaxIndex = curGuessedName.length - 1;
        if (curGuessedNameMaxIndex < i) {
          continue;
        }
        var finalNameChar = finalName.characters.elementAt(i).toLowerCase();
        var curGuessedNameChar = curGuessedName.characters.elementAt(i).toLowerCase();
        if (finalNameChar == curGuessedNameChar) {
          foundIndexes.add(i);
          continue outer;
        }
      }
    }
    return foundIndexes;
  }

  List<Container> foundLetterWidgets() {
    Set<int> foundIndexesSet = foundIndexes();
    if (foundIndexesSet.isEmpty) {
      // return [const TextSpan(text: " ", style: characterStyle)];
      return [];
    }
    var foundIndexesSorted = foundIndexesSet.toList(growable: true);
    foundIndexesSorted.sort();
    var firstFoundIndex = foundIndexesSorted.first;
    var lastFoundIndex = foundIndexesSorted.last;

    var widgets = List<Container>.empty(growable: true);
    print(finalName);
    for (var i = firstFoundIndex; i <= lastFoundIndex; i++) {
      var isFound = foundIndexesSet.contains(i);
        var character = isFound ? finalName.characters.elementAt(i)
            .toUpperCase() : " ";
      var container = Container(
        width: 45.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
        decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(255, 255, 255, 1.0))),
        child: Center(child: RichText(text: TextSpan(text: character, style: characterStyle))),
      );
      widgets.add(container);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: foundLetterWidgets());
  }
}
