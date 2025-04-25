import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

void main() {
  runApp(const FuriaApp());
}

class FuriaApp extends StatelessWidget {
  const FuriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FuriaVerso',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const LoginScreen(), //tela de login
    );
  }
}
