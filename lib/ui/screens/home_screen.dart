import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/ui/models/game_state.dart';
import 'package:tictactoe/ui/screens/game_screen.dart';
import 'package:tictactoe/ui/screens/leader_board_screen.dart';
import 'package:tictactoe/ui/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tic Tac Toe')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.account_box_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                gameState.resetGame();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text('Start New Game'),
            ),
            const SizedBox(height: 20),
            if (gameState.winner.isEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                child: const Text('Resume Play'),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                );
              },
              child: const Text('View Leaderboard'),
            ),
          ],
        ),
      ),
    );
  }
}
