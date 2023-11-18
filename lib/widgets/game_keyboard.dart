import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:word_games/utils/game_provider.dart';
import 'package:word_games/widgets/game_board.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key);
  WordGame game;
  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List row1 = "QWERTYUIOP".split("");
  List row2 = "ASDFGHJKL".split("");
  List row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  void _restartGame() {
    setState(() {
      // Reset game variables or clear the data structures
      widget.game = WordGame(); // Create a new instance of WordGame
      WordGame.game_message = ""; // Reset game messages or flags
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          WordGame.game_message,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20.0,
        ),
        GameBoard(widget.game),
        const SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.map((e) {
            return InkWell(
              onTap: () {
                print(e);
                if (widget.game.letterId < 5) {
                  print(widget.game.rowId);
                  widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                  widget.game.letterId++;
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  "${e}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map((e) {
            return InkWell(
              onTap: () {
                print(e);
                if (widget.game.letterId < 5) {
                  print(widget.game.rowId);
                  widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                  widget.game.letterId++;
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  "${e}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map((e) {
            return InkWell(
              onTap: () {
                print(e);

                if (e == "DEL") {
                  if (widget.game.letterId > 0) {
                    setState(() {
                      widget.game
                          .insertWord(widget.game.letterId - 1, Letter("", 0));
                      widget.game.letterId--;
                    });
                  }
                } else if (e == "SUBMIT") {
                  if (widget.game.letterId >= 5) {
                    /* widget.game.wordleBoard[widget.game.rowId].replaceRange(
                      0,
                      5,
                      List.generate(5, (index) => Letter("", 3)),
                    ); */
                    String guess = widget.game.wordBoard[widget.game.rowId]
                        .map((e) => e.letter)
                        .join();
                    print(guess);
                    print(WordGame.game_guess == guess);
                    if (widget.game.checkWordExist(guess.toLowerCase())) {
                      if (guess == WordGame.game_guess) {
                        setState(() {
                          WordGame.game_message = "Congratulations🎉";
                          widget.game.wordBoard[widget.game.rowId]
                              .forEach((element) {
                            element.code = 1;
                          });
                        });
                      } else {
                        print(WordGame.game_guess);
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++) {
                          String char = guess[i].toUpperCase();
                          print(
                              "the test: ${WordGame.game_guess.contains(char)}");
                          if (WordGame.game_guess.contains(char)) {
                            if (WordGame.game_guess[i] == char) {
                              setState(() {
                                print(char);
                                widget.game.wordBoard[widget.game.rowId][i]
                                    .code = 1;
                              });
                            } else {
                              setState(() {
                                print(char);
                                widget.game.wordBoard[widget.game.rowId][i]
                                    .code = 2;
                              });
                            }
                          }
                        }
                        widget.game.rowId++;
                        widget.game.letterId = 0;
                      }
                    } else {
                      WordGame.game_message =
                      "the world does not exist try again";
                    }
                  }
                } else {
                  if (widget.game.letterId < 5) {
                    print(widget.game.rowId);
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  "${e}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: _restartGame,
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Background color
            onPrimary: Colors.black, // Text color
            minimumSize: const Size(140, 52), // Width and height of the button
          ),
          child: const Text(
            'Restart Game',
            style: TextStyle(color: Colors.black), // Text color
          ),
        ),

      ],
    );
  }
}
