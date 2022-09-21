import 'package:flutter/cupertino.dart';
import 'package:itverket_itdagene_flutter/utils/highscore_entry.dart';
import 'package:itverket_itdagene_flutter/utils/highscore_entry_collection.dart';

class Highscore extends StatelessWidget {
  const Highscore({Key? key}) : super(key: key);

  Future<HighscoreEntryCollection> _loadHighscore() async {
    return await HighscoreEntryCollection.load();
  }

  List<RichText> highscoreWidgets(HighscoreEntryCollection collection) {
    List<RichText> widgets = List.empty(growable: true);
    var value_list = collection.entries.values.toList();
    value_list.sort((a, b) => b.score.compareTo(a.score));
    var iter = value_list.iterator;
    var pos = 0;
    while(iter.moveNext()) {
      pos += 1;
      var cur = iter.current;
      var name = cur.name;
      var score = cur.score;
      widgets.add(RichText(text: TextSpan(text: "$pos. $name $score", style: TextStyle(fontSize: 40))));
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
            var title = Container(padding: const EdgeInsets.symmetric(vertical: 25.0),child: RichText(text: const TextSpan(text:"HIGHSCORE", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold))));
            var highscoreWidgetList = highscoreWidgets(collection);
            return Column(children: [title, Column(crossAxisAlignment: CrossAxisAlignment.start,children: highscoreWidgetList,)]);
          } else {
            return const Text("Loading");
          }
        }
    );
  }
}