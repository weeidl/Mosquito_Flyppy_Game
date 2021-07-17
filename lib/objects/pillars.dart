import 'package:flutter/material.dart';

class Pillars extends StatelessWidget {
  final pillarsWidth;
  final pillarsHeight;
  final pillarsX;
  final bool bottomPillars;

  Pillars(
      {this.pillarsHeight,
      this.pillarsWidth,
      required this.bottomPillars,
      this.pillarsX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * pillarsX + pillarsWidth) / (2 - pillarsWidth),
          bottomPillars ? 1 : -1),
      child: Container(
        // color: Colors.green,

        width: MediaQuery.of(context).size.width * pillarsWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * pillarsHeight / 2,
        child: Image.asset(
          'assets/pillars.png',
          // width: 100,
          // height: 50,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
