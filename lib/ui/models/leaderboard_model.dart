class LeaderboardModel {
  final String username;
  final int score;
  final int gamesWon;
  final int gamesLost;

  LeaderboardModel({
    required this.username,
    required this.score,
    required this.gamesWon,
    required this.gamesLost,
  });

  // Convert a LeaderboardModel object into a Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'score': score,
      'gamesWon': gamesWon,
      'gamesLost': gamesLost,
    };
  }

  // Convert a Map into a LeaderboardModel object
  factory LeaderboardModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardModel(
      username: map['username'],
      score: map['score'],
      gamesWon: map['gamesWon'],
      gamesLost: map['gamesLost'],
    );
  }
}
