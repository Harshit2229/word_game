import 'package:flutter/material.dart';
import 'package:word_games/utils/game_provider.dart';
import 'package:word_games/widgets/game_board.dart';
import 'package:word_games/widgets/game_keyboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  WordGame _game = WordGame();
  late String word;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WordGame.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "Word Game",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10,),
              Icon(
                Icons.gamepad,
                size: 50,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 10),
          GameKeyboard(_game),
        ],
      ),
    );
  }
}
