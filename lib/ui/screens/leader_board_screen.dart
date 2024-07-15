import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> leaderboardData = [
    {'username': 'Alice', 'gamesPlayed': 15, 'gamesWon': 10},
    {'username': 'Bob', 'gamesPlayed': 12, 'gamesWon': 8},
    {'username': 'Charlie', 'gamesPlayed': 18, 'gamesWon': 12},
    {'username': 'David', 'gamesPlayed': 20, 'gamesWon': 15},
    {'username': 'Eve', 'gamesPlayed': 14, 'gamesWon': 9},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: ListView.builder(
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          final playerData = leaderboardData[index];
          return ListTile(
            leading: CircleAvatar(child: Text((index + 1).toString())),
            title: Text(playerData['username']),
            subtitle: Text(
                'Games Played: ${playerData['gamesPlayed']}, Games Won: ${playerData['gamesWon']}'),
            // Add onTap functionality if needed
          );
        },
      ),
    );
  }
}
