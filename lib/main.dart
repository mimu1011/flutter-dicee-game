import 'package:flutter/material.dart';

import 'common.dart';
import 'game.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black12,
          body: DicePage(),
        ),
      ),
    );

// 0F5CBF, 027333, F2A71B, F23D3D

class DicePage extends StatefulWidget {
  DicePage({Key key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  var game = Game(1);

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
                      CustomText(
                        game.first.name.toUpperCase(),
                        color: Colors.black,
                      ),
                      Text(game.first.score.toString())
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomText(
                        game.second.name.toUpperCase(),
                        color: Colors.black,
                      ),
                      Text(game.second.score.toString())
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
                child: Image.asset("images/dice${game.first.diceNumber}.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/dice${game.second.diceNumber}.png"),
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
                  onPressed: game.first.turn && !game.disable
                      ? () => onPlayer1PressButton()
                      : null,
                  child: CustomText(
                    game.first.name,
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
                  onPressed: game.second.turn && !game.disable
                      ? () => onPlayer2PressButton()
                      : null,
                  child: CustomText(game.second.name),
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
              margin: const EdgeInsets.only(top: 40.0),
              child: getCustomText(),
            ),
            game.hasWinner()
                ? FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Restart"),
                    onPressed: () {
                      setState(() {
                        game.start();
                      });
                    },
                  )
                : SizedBox()
          ],
        )
      ],
    );
  }

  onPlayer1PressButton() {
    setState(() {
      print(game.first.diceNumber);
      game.first.shuffle();
      print(game.first.diceNumber);

      game.switchTurn();
      print(game.first);
    });
  }

  onPlayer2PressButton() {
    setState(() {
      game.second.shuffle();
      game.switchTurn();
      game.calculateRound();
    });
  }

  getCustomText() {
    if (game.hasWinner()) {
      return CustomText(
        "PLAYER ${game.winner} HAS WON!",
        color: Colors.amber,
      );
    } else {
      return CustomText(
        "Play until you score 5!",
      );
    }
  }
}
