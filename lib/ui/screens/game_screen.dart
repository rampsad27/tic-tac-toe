import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../widgets/game_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gameState.winner.isNotEmpty
                  ? 'Winner: ${gameState.winner}'
                  : 'Current Player: ${gameState.currentPlayer}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            const GameBoard(),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: gameState.resetGame,
              child: const Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
