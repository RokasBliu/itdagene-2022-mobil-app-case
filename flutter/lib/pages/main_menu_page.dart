import 'package:flutter/material.dart';
import 'package:itverket_itdagene_flutter/pages/colleagues_image_page.dart';
import 'package:itverket_itdagene_flutter/pages/colleagues_name_page.dart';
import 'package:itverket_itdagene_flutter/pages/game.dart';
import 'package:itverket_itdagene_flutter/pages/highscore.dart';
import 'package:itverket_itdagene_flutter/theme/palette.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: Game(key: key),
        child: Column(children: [
          Column(
            children: const [
              Center(child: Image(image: AssetImage('images/logo_black.png'))),
              Center(
                child: Text(
                  'KNOWELL',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize:50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Center(
              child:
                  _modeButton(context, Scaffold(body: Game(key: key)), "GAME")),
          _modeButton(context, Scaffold(body: Highscore(key: key)), "HIGHSCORE")
        ]),
      ),
    );
  }

  Padding _modeButton(BuildContext context, Widget route, String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () => _navigateToRoute(context, route),
        style: TextButton.styleFrom(
            side: const BorderSide(color: Palette.primary),
            textStyle: const TextStyle(fontSize: 40)),
        child: Text(buttonText),
      ),
    );
  }

  Future<dynamic> _navigateToRoute(BuildContext context, Widget route) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }
}
