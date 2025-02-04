import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final List<String> stuff;
  const Input(this.stuff, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 51.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stuff
              .map((s) => _buildKey(MediaQuery.of(context).size.width / 12, s))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildKey(double width, String text) {
    return SizedBox(
      width: width,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey.shade500,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            color: Colors.grey.shade500,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
