part of 'googlesignin_bloc.dart';

abstract class GooglesigninState extends Equatable {
  const GooglesigninState();

  @override
  List<Object> get props => [];
}

class GooglesigninInitial extends GooglesigninState {}

class Authenticated extends GooglesigninState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class UnAuthenticated extends GooglesigninState {}

class LogInLoadInProgress extends GooglesigninState {}

class LogoutSuccess extends GooglesigninState {
  final String logoutSuccessMessage;

  const LogoutSuccess({
    required this.logoutSuccessMessage,
  });

  @override
  List<Object> get props => [logoutSuccessMessage];
}
