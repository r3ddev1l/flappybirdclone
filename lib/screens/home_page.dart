import 'dart:async';

import 'package:flappy_bird_clone/barrier.dart';
import 'package:flappy_bird_clone/my_bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool isGameStated = false;

  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;

  void jump() {
    setState(() {
      time = 0;
    });
  }

  void startGame() {
    isGameStated = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYAxis = initialHeight - height;
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3;
        } else {
          barrierXTwo -= 0.05;
        }
      });
      if (birdYAxis > 1) {
        timer.cancel();
        isGameStated = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGameStated) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: Text(
                      isGameStated ? "" : "T A P   T O   P L A Y",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  AnimatedContainer(
                      alignment: Alignment(barrierXOne, 1.06),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(height: 200.0)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXTwo, -1.06),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(height: 170.0)),
                ],
              ),
            ),
            Container(
              color: Colors.green,
              height: 15,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Best',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
