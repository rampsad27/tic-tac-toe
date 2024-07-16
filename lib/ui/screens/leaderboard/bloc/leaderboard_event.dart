part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class SaveScore extends LeaderboardEvent {
  final String username;
  final int score;

  const SaveScore({
    required this.username,
    required this.score,
  });

  @override
  List<Object> get props => [username, score];
}

class UpdateGameStats extends LeaderboardEvent {
  final bool won;

  const UpdateGameStats({
    required this.won,
  });

  @override
  List<Object> get props => [won];
}
