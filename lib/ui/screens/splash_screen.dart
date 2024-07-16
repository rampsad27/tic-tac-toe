import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tictactoe/ui/screens/home_screen.dart';
import 'package:tictactoe/ui/screens/sso_login/log_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate a splash screen delay
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    });

    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/a.png",
        fit: BoxFit.cover,
      )),
    );
  }
}
