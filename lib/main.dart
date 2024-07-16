import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/firebase_options.dart';
import 'package:tictactoe/ui/models/game_state.dart';
import 'package:tictactoe/ui/screens/splash_screen.dart';
import 'package:tictactoe/ui/screens/sso_login/bloc/googlesignin_bloc.dart';
import 'package:tictactoe/repo/googleSignIn_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final GoogleSignInRepository googleSignInRepository =
      GoogleSignInRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameState()),
        BlocProvider(
          create: (context) => GooglesigninBloc(googleSignInRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
