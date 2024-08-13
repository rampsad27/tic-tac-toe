import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/repo/googleSignIn_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'googlesignin_event.dart';
part 'googlesignin_state.dart';

class GooglesigninBloc extends Bloc<GooglesigninEvent, GooglesigninState> {
  final GoogleSignInRepository _googleSignInRepository;

  GooglesigninBloc(
      this._googleSignInRepository) //constructor to initialize the the BLoC with a GoogleSignInRepository instance
      : super(GooglesigninInitial()) {
    on<CheckLoggedInUser>((event, emit) async {
      emit(LogInLoadInProgress());
      try {
        final user = await _googleSignInRepository.getUserInfo();
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(UnAuthenticated());
      }
    });

    on<LogOutRequested>((event, emit) async {
      emit(LogInLoadInProgress());
      await _googleSignInRepository.signOut();
      emit(
          const LogoutSuccess(logoutSuccessMessage: "Logged out successfully"));
    });
  }
}
