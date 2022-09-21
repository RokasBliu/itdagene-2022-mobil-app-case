import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final List<String> stuff;
  const Input(this.stuff, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: stuff.map((s) => Text(s)).toList());
  }
}
