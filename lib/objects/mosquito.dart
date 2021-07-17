import 'package:flutter/material.dart';

class Mosquito extends StatelessWidget {
  final mosquitoY;
  final double mosquitoWidth;
  final double mosquitoHeight;

  Mosquito(
      {this.mosquitoY,
      required this.mosquitoWidth,
      required this.mosquitoHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          Alignment(0, (2 * mosquitoY + mosquitoHeight) / (2 - mosquitoHeight)),
      child: Image.asset(
        'assets/mosquito.png',
        width: 100,
        height: 50,
        fit: BoxFit.fill,
      ),
    );
  }
}
