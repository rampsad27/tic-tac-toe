import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameState with ChangeNotifier {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  String? _playerX;
  String? _playerO;
  User? _user;

  List<String> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;
  String? get playerX => _playerX;
  String? get playerO => _playerO;
  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  void makeMove(int index) {
    if (_board[index] == '' && _winner == '') {
      _board[index] = _currentPlayer;
      _checkWinner();
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      notifyListeners();
    }
  }

  void _checkWinner() {
    const List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var positions in winningPositions) {
      if (_board[positions[0]] == _board[positions[1]] &&
          _board[positions[1]] == _board[positions[2]] &&
          _board[positions[0]] != '') {
        _winner = _board[positions[0]];
        _saveGameResult();
        break;
      }
    }

    if (!_board.contains('') && _winner == '') {
      _winner = 'Draw';
      _saveGameResult();
    }
  }

  void resetGame() {
    _board = List.filled(9, '');
    _currentPlayer = 'X';
    _winner = '';
    notifyListeners();
  }

  void setPlayers(String playerX, String playerO) {
    _playerX = playerX;
    _playerO = playerO;
    notifyListeners();
  }

  Future<void> _saveGameResult() async {
    final firestore = FirebaseFirestore.instance;
    final gameResult = {
      'playerX': _playerX,
      'playerO': _playerO,
      'winner': _winner,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await firestore.collection('games').add(gameResult);
    _updateLeaderboard();
  }

  Future<void> _updateLeaderboard() async {
    final firestore = FirebaseFirestore.instance;
    if (_winner == 'X') {
      await firestore.collection('leaderboard').doc(_user!.uid).set({
        'username': _playerX,
        'gamesWon': FieldValue.increment(1),
        'gamesLost': FieldValue.increment(0),
      }, SetOptions(merge: true));
    } else if (_winner == 'O') {
      await firestore.collection('leaderboard').doc(_user!.uid).set({
        'username': _playerO,
        'gamesWon': FieldValue.increment(1),
        'gamesLost': FieldValue.increment(0),
      }, SetOptions(merge: true));
    } else {
      // Handle the draw case if needed
    }
  }
}
