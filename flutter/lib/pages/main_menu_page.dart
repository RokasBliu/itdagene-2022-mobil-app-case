import 'package:flutter/material.dart';
import 'package:itverket_itdagene_flutter/pages/colleagues_image_page.dart';
import 'package:itverket_itdagene_flutter/pages/colleagues_name_page.dart';
import 'package:itverket_itdagene_flutter/pages/game.dart';
import 'package:itverket_itdagene_flutter/theme/palette.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Game(key: key));
  }

  Padding _modeButton(BuildContext context, Widget route, String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () => _navigateToRoute(context, route),
        style: TextButton.styleFrom(
          side: const BorderSide(color: Palette.primary),
        ),
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
