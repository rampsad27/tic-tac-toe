// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tictactoe/repo/leaderboard_repository.dart';

// part 'leaderboard_event.dart';
// part 'leaderboard_state.dart';

// class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
//   final LeaderboardRepository _repository;

//   LeaderboardBloc(this._repository) : super(LeaderboardInitial()) {
//     on<SaveScore>((event, emit) async {
//       emit(LeaderboardLoading());

//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) {
//         emit(const LeaderboardError("No user logged in"));
//         return;
//       }

//       try {
//         await _repository.saveScore(
//           currentUser.uid,
//           event.username,
//           event.score,
//         );
//         emit(LeaderboardLoaded());
//       } catch (e) {
//         emit(LeaderboardError(e.toString()));
//       }
//     });

//     on<UpdateGameStats>((event, emit) async {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) {
//         emit(const LeaderboardError("No user logged in"));
//         return;
//       }

//       try {
//         await _repository.updateGameStats(currentUser.uid, event.won);
//         emit(LeaderboardLoaded());
//       } catch (e) {
//         emit(LeaderboardError(e.toString()));
//       }
//     });
//   }
// }
