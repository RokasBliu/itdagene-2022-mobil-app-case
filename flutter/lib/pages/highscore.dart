import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:itverket_itdagene_flutter/utils/highscore_entry.dart';
import 'package:itverket_itdagene_flutter/utils/highscore_entry_collection.dart';

class Highscore extends StatelessWidget {
  const Highscore({Key? key}) : super(key: key);

  Future<HighscoreEntryCollection> _loadHighscore() async {
    return await HighscoreEntryCollection.load();
  }

  List<Center> highscoreWidgets(HighscoreEntryCollection collection) {
    List<Center> widgets = List.empty(growable: true);
    var value_list = collection.entries.values.toList();
    value_list.sort((a, b) => b.score.compareTo(a.score));
    var iter = value_list.iterator;
    var pos = 0;
    while(iter.moveNext()) {
      pos += 1;
      var cur = iter.current;
      var name = cur.name;
      var score = cur.score;
      var style = const TextStyle(fontSize: 30, color: Color.fromRGBO(255, 0, 0, 1.0));
      widgets.add(Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        RichText(
            text: TextSpan(text: "$pos.", style: style)
        ),
        RichText(
            text: TextSpan(text: name, style: style)
        ),
        RichText(
            text: TextSpan(text: "$score", style: style)
        )
      ]))));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadHighscore(),
        builder: (BuildContext context, AsyncSnapshot<HighscoreEntryCollection> snapshot) {
          HighscoreEntryCollection? collection = snapshot.data;
          if (collection != null) {
            var title = Container(padding: const EdgeInsets.symmetric(vertical: 25.0),child: RichText(text: const TextSpan(text:"HIGHSCORE", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 0, 0, 1.0)))));
            var highscoreWidgetList = highscoreWidgets(collection);
            return Column(children: [Center(child: title), Column(crossAxisAlignment: CrossAxisAlignment.start,children: highscoreWidgetList,)]);
          } else {
            return const Text("Loading");
          }
        }
    );
  }
}