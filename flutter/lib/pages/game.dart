import 'package:flutter/cupertino.dart';
import 'package:itverket_itdagene_flutter/components/game_image.dart';
import 'package:itverket_itdagene_flutter/components/game_text.dart';
import 'package:itverket_itdagene_flutter/domain/colleagues.dart';
import 'package:itverket_itdagene_flutter/utils/highscore_entry.dart';
import 'package:itverket_itdagene_flutter/utils/highscore_entry_collection.dart';
import 'package:itverket_itdagene_flutter/utils/names.dart';
import 'package:itverket_itdagene_flutter/widgets/inner.dart';
import '../domain/colleague.dart';

class Game extends StatefulWidget {
  ColleagueCollection colleagues;

  Game({Key? key})
      : colleagues = ColleagueCollection.newEmpty(),
        super(key: key);

  @override
  State<Game> createState() => _GameState(colleagues);
}

class _GameState extends State<Game> {
  ColleagueCollection colleagues;
  Colleague? curColleague;
  Set<String> guessedNames;

  _GameState(this.colleagues)
      : guessedNames = {},
        super();

  Future<Colleague> _fetchAndPop() =>
      colleagues.fetchAll().then((_) => colleagues.popRandom());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchAndPop(),
        builder: (BuildContext context, AsyncSnapshot<Colleague> snapshot) {
          var colleague = snapshot.data;
          if (colleague != null) {
            return Column(children: [
              Align(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 7,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),child: FittedBox(
                          fit: BoxFit.contain,
                          child: GameImage(snapshot.data?.imageUrl ?? ""))))),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 7,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                          child: GameText(colleague.firstName(), guessedNames)),
                      Inner(colleague.firstName().toUpperCase(), (turns) {
                  HighscoreEntryCollection.loadAddThenSave(HighscoreEntry("Joachim", 1));
                  Navigator.pop(context);
                }),
                    ],
                  ))
            ]);
          } else {
            return const Center(
              child: Text("LOADING"),
            );
          }
        });
  }
}
