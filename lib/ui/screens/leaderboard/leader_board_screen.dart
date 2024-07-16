import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Results'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No game results available'));
          }

          final gameResults = snapshot.data!.docs;

          return ListView.builder(
            itemCount: gameResults.length,
            itemBuilder: (context, index) {
              var gameData = gameResults[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text('Game ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Player X: ${gameData['playerX']}'),
                    Text('Player O: ${gameData['playerO']}'),
                    Text('Winner: ${gameData['winner']}'),
                    Text(
                        'Timestamp: ${(gameData['timestamp'] as Timestamp).toDate()}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
