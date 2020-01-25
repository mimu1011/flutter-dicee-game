import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: DicePage(),
      ),
    ),
  );
}

// 0F5CBF, 027333, F2A71B, F23D3D

class DicePage extends StatefulWidget {
  DicePage({Key key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  int flexValue = 1;

  int score1 = 0;
  int score2 = 0;

  int winner = 0;

  bool isFirstPlayersTurn = true;
  bool isSecondPlayersTurn = false;
  bool disable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.only(top: 50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "LEADERBOARD",
                    style: TextStyle(fontSize: 25.0, letterSpacing: 18),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "PLAYER 1: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(score1.toString())
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "PLAYER 2: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(score2.toString())
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/dice$leftDiceNumber.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/dice$rightDiceNumber.png"),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: const Color(0xFF0A73BF),
                  onPressed: isFirstPlayersTurn && !disable
                      ? () => onPlayer1PressButton()
                      : null,
                  child: Text(
                    "Player 1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: const Color(0xFF0A73BF),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: isSecondPlayersTurn && !disable
                      ? () => onPlayer2PressButton()
                      : null,
                  child: Text(
                    "Player 2",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 70.0),
              child: getText(),
            )
          ],
        )
      ],
    );
  }

  onPlayer1PressButton() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      isFirstPlayersTurn = false;
      isSecondPlayersTurn = true;
    });
  }

  onPlayer2PressButton() {
    setState(() {
      rightDiceNumber = Random().nextInt(6) + 1;
      isFirstPlayersTurn = true;
      isSecondPlayersTurn = false;
      calculate();
    });
  }

  calculate() {
    if (leftDiceNumber > rightDiceNumber) {
      score1++;
    } else if (leftDiceNumber < rightDiceNumber) {
      score2++;
    }

    if (score1 == 5) {
      winner = 1;
      isFirstPlayersTurn = true;
      isSecondPlayersTurn = false;
      disable = true;
    }

    if (score2 == 5) {
      winner = 2;
      isFirstPlayersTurn = true;
      isSecondPlayersTurn = false;

      disable = true;
    }
  }

  getText() {
    if (winner == 1 || winner == 2) {
      return Text(
        "Player $winner has WON!",
        style: TextStyle(color: Colors.amber, fontSize: 30.0),
      );
    } else {
      return Text(
        "Play until you score 5!",
        style: TextStyle(color: Colors.white, fontSize: 25.0),
      );
    }
  }
}

class DisplayText extends StatelessWidget {
  final String _message;

  const DisplayText(this._message, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this._message,
      style: TextStyle(color: Colors.white, fontSize: 25.0),
    );
  }
}
