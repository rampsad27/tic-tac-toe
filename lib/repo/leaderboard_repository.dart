// import 'package:cloud_firestore/cloud_firestore.dart';

// class LeaderboardRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> saveScore(String userId, String username, int score) async {
//     final leaderboardRef = _firestore.collection('leaderboard');

//     await leaderboardRef.doc(userId).set({
//       'username': username,
//       'score': score,
//       'gamesWon': 0,
//       'gamesLost': 0,
//       'timestamp': FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//   }

//   Future<void> updateGameStats(String userId, bool won) async {
//     final leaderboardRef = _firestore.collection('leaderboard');

//     if (won) {
//       await leaderboardRef.doc(userId).update({
//         'gamesWon': FieldValue.increment(1),
//       });
//     } else {
//       await leaderboardRef.doc(userId).update({
//         'gamesLost': FieldValue.increment(1),
//       });
//     }
//   }
// }
