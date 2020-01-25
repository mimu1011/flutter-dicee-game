import 'dart:math';

class Game {
  int winner;
  int limit = 5;
  int eqaulDice = 0;
  bool disable = false;

  Player first;
  Player second;

  Game(this.limit) {
    start();
  }

  start() {
    first = Player("Player 1", 0, true);
    second = Player("Player 2", 0, false);
    winner = 0;
    disable = false;
  }

  calculateRound() {
    if (first.diceNumber > second.diceNumber) {
      first.score++;
    } else if (first.diceNumber < second.diceNumber) {
      second.score++;
    } else {
      eqaulDice++;
    }
    
    analyseWinner();
  }

  switchTurn() {
    first.turn = !first.turn;
    second.turn = !second.turn;
  }

  analyseWinner() {
    if (first.score == limit) {
      winner = 1;
      freeze();
    }

    if (second.score == limit) {
      winner = 2;
      freeze();
    }
  }

  freeze() {
    disable = true;
  }

  hasWinner() {
    return winner > 0;
  }
}

class Player {
  String name;
  int score = 0;
  bool turn = false;
  int diceNumber = 1;

  Player(this.name, this.score, this.turn);

  shuffle() {
    diceNumber = Random().nextInt(6) + 1;
  }
}
