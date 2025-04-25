import 'package:flutter/material.dart';
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
      ),
      home: const LoginScreen(), //tela de login
    );
  }
}
