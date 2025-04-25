import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env"); // Carrega as variáveis de ambiente

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      appId: dotenv.env['FIREBASE_APP_ID']!,
      projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    ),
  );
  print('Firebase initialized successfully!');	
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
