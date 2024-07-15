import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/repo/googleSignIn_repository.dart';
import 'package:tictactoe/ui/screens/home_screen.dart';

import 'package:tictactoe/ui/screens/sso_login/bloc/googlesignin_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GoogleSignInRepository _googleSignInRepository;
  late GooglesigninBloc _googlesigninBloc;

  @override
  void initState() {
    super.initState();
    _googleSignInRepository = GoogleSignInRepository();
    _googlesigninBloc = GooglesigninBloc(_googleSignInRepository);
    _googlesigninBloc.add(CheckLoggedInUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _googlesigninBloc,
      child: BlocListener<GooglesigninBloc, GooglesigninState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is UnAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign in failed. Please try again.'),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user =
                          await _googleSignInRepository.signInWithGoogle();
                      _googlesigninBloc.add(CheckLoggedInUser());
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cannot sign in. Please try again.'),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign in with Google"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
