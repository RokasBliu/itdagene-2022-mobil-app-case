import 'package:flutter/cupertino.dart';
import 'package:itverket_itdagene_flutter/domain/colleagues.dart';

class Game extends StatefulWidget {
  ColleagueCollection colleagues;

  Game({Key? key}) : colleagues = ColleagueCollection.newEmpty(), super(key: key);

  @override
  State<Game> createState() => _GameState(colleagues);
}

class _GameState extends State<Game> {
  ColleagueCollection colleagues;

  _GameState(this.colleagues) : super();

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      Text("IMAGE"),
      Text("TEXT"),
      Text("KEYBOARD")
    ],);
  }
}