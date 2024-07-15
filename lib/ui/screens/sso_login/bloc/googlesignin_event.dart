part of 'googlesignin_bloc.dart';

sealed class GooglesigninEvent extends Equatable {
  const GooglesigninEvent();

  @override
  List<Object> get props => [];
}

class CheckLoggedInUser extends GooglesigninEvent {}

final class LogOutRequested extends GooglesigninEvent {}
