import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/ui/models/game_state.dart';
import 'package:tictactoe/ui/screens/game_screen.dart';
import 'package:tictactoe/ui/screens/leader_board_screen.dart';
import 'package:tictactoe/ui/screens/profile_screen.dart';
import 'package:tictactoe/ui/screens/sso_login/bloc/googlesignin_bloc.dart';
import 'package:tictactoe/ui/widgets/sidetransition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GooglesigninBloc>(context).add(CheckLoggedInUser());
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the GameState from Provider
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                SlideTransitionRoute(page: const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.account_box_outlined),
          ),
        ],
      ),
      body: ParallaxRain(
        distanceBetweenLayers: 1,
        dropHeight: 12,
        key: GlobalKey(),
        dropColors: const [Colors.green, Colors.lightGreen, Colors.greenAccent],
        trail: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Show opponent dialog
                  _showOpponentDialog(context, gameState);
                },
                child: const Text('Start New Game'),
              ),
              const SizedBox(height: 20),
              // Only show Resume Play button if there's no winner
              if (gameState.winner.isEmpty)
                ElevatedButton(
                  onPressed: () {
                    // Navigate to GameScreen to resume
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen()),
                    );
                  },
                  child: const Text('Resume Play'),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LeaderboardScreen(),
                    ),
                  );
                },
                child: const Text('View Leaderboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOpponentDialog(BuildContext context, GameState gameState) {
    final TextEditingController opponentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your opponent\'s name'),
          content: TextField(
            controller: opponentController,
            decoration: const InputDecoration(hintText: "Opponent's Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String opponentName = opponentController.text;
                if (opponentName.isNotEmpty) {
                  gameState.resetGame();

                  User? user =
                      FirebaseAuth.instance.currentUser; // Reset the game state
                  String? playerDisplayName = user?.displayName;

                  // Check if playerDisplayName is not null
                  if (playerDisplayName != null) {
                    gameState.setPlayers(
                      playerDisplayName,
                      opponentName,
                    ); // Set players
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  } else {
                    // Handle case where playerDisplayName is null
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error: Player name is null.'),
                      ),
                    );
                  }
                } else {
                  // Show error if opponent name is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error: Opponent name cannot be empty.'),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
