import 'package:flutter/material.dart';

class LowerBar extends StatelessWidget {
  final int time;
  final int betsTime;

  LowerBar(this.time, this.betsTime);
  @override
  Widget build(BuildContext context) {
    TextStyle textStyleLong = TextStyle(color: Colors.white, fontSize: 35);
    TextStyle textStyleSmall = TextStyle(color: Colors.white, fontSize: 20);
    return Container(
      color: Colors.blueGrey[800],
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$time', style: textStyleLong),
                SizedBox(height: 15),
                Text('T I M E', style: textStyleSmall),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$betsTime', style: textStyleLong),
                SizedBox(height: 15),
                Text('B E S T  T I M E', style: textStyleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
