import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('leaderboard').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final leaderboard = snapshot.data!.docs;

          return ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              var userData = leaderboard[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(userData['username']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Games Won: ${userData['gamesWon']}'),
                    Text('Games Lost: ${userData['gamesLost']}'),
                    Text('Games Drawn: ${userData['gamesDrawn']}'),
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
