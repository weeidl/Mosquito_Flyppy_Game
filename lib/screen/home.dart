import 'dart:async';

import 'package:flappy_mosquito_game/objects/lower_bar.dart';
import 'package:flappy_mosquito_game/objects/pillars.dart';
import 'package:flutter/material.dart';

import '../objects/mosquito.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double mosquitoY = 0;
  double initialPos = mosquitoY;
  double height = 0;
  double timeGame = 0;
  int time = 0;
  int betsTime = 0;
  double gravity = -4.9;
  double velocity = 3.5;
  double mosquitoWidth = 0.1;
  double mosquitoHeight = 0.1;
  bool gameStarted = false;
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameStarted = true;

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * timeGame * timeGame + velocity * timeGame;

      setState(() {
        mosquitoY = initialPos - height;
      });
      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      moveMap();
      timeGame += 0.01;
    });
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        time += 1;
        if (time > betsTime) {
          betsTime = time;
        }
      });
      print(time);
      if (birdIsDead()) {
        timer.cancel();
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      mosquitoY = 0;
      gameStarted = false;
      timeGame = 0;
      initialPos = mosquitoY;
      barrierX = [2, 2 + 1.5];
      time = 0;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey[800],
            title: Center(
              child: Text(
                "I FEEL SORRY FOR THE MOSQUITO",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      timeGame = 0;
      initialPos = mosquitoY;
    });
  }

  bool birdIsDead() {
    if (mosquitoY < -1 || mosquitoY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= mosquitoWidth &&
          barrierX[i] + barrierWidth >= -mosquitoWidth &&
          (mosquitoY <= -1 + barrierHeight[i][0] ||
              mosquitoY + mosquitoHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/fon.jpg'),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Stack(
                    children: [
                      // bird
                      Mosquito(
                        mosquitoY: mosquitoY,
                        mosquitoWidth: mosquitoWidth,
                        mosquitoHeight: mosquitoHeight,
                      ),

                      if (!gameStarted)
                        Container(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            'T A P  T O  P L A Y',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      if (!gameStarted)
                        Container(
                          alignment: Alignment(0, -0.32),
                          child: Text(
                            'HELP THE MOSQUITO TO SURVIVE',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      Pillars(
                        pillarsX: barrierX[0],
                        pillarsWidth: barrierWidth,
                        pillarsHeight: barrierHeight[0][0],
                        bottomPillars: false,
                      ),
                      Pillars(
                        pillarsX: barrierX[0],
                        pillarsWidth: barrierWidth,
                        pillarsHeight: barrierHeight[0][1],
                        bottomPillars: true,
                      ),
                      Pillars(
                        pillarsX: barrierX[1],
                        pillarsWidth: barrierWidth,
                        pillarsHeight: barrierHeight[1][0],
                        bottomPillars: false,
                      ),
                      Pillars(
                        pillarsX: barrierX[1],
                        pillarsWidth: barrierWidth,
                        pillarsHeight: barrierHeight[1][1],
                        bottomPillars: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 18,
              color: Colors.green,
            ),
            Expanded(
              child: LowerBar(time, betsTime),
            ),
          ],
        ),
      ),
    );
  }
}
