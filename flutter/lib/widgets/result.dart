import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List<String> target;
  final List<bool> found;
  const Result(this.target, this.found, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> thing = [];

    target.asMap().forEach((i, c) => {
          thing.add(
              _buildKey(MediaQuery.of(context).size.width / 12, c, found[i]))
        });

    int highest = -1;
    for (int i = 0; i < target.length; i++) {
      if (found[i]) {
        highest = i;
      }
    }

    for (int i = highest + 1; i < target.length; i++) {
      thing.removeLast();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 51.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: thing,
        ),
      ),
    );
  }

  Widget _buildKey(double width, String text, bool found) {
    return SizedBox(
      width: width,
      height: 35,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: found ? Colors.green : Colors.grey.shade500,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            color: found ? Colors.green : Colors.grey.shade500,
          ),
          child: Text(
            found ? text : "",
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
