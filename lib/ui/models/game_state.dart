import 'package:flutter/material.dart';

class GameState with ChangeNotifier {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';

  List<String> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;

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
        break;
      }
    }

    if (!_board.contains('') && _winner == '') {
      _winner = 'Draw';
    }
  }

  void resetGame() {
    _board = List.filled(9, '');
    _currentPlayer = 'X';
    _winner = '';
    notifyListeners();
  }
}
