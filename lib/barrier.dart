import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final height;

  Barrier({@required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: Colors.green[900],
          width: 5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 50,
      height: height,
    );
  }
}
