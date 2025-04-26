import 'package:flutter/foundation.dart'; // Para usar kIsWeb
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega o arquivo .env
  await dotenv.load(fileName: ".env");

  // Seleciona as chaves corretas com base na plataforma
  final apiKey =
      kIsWeb
          ? dotenv.env['FIREBASE_API_KEY_WEB']
          : defaultTargetPlatform == TargetPlatform.android
          ? dotenv.env['FIREBASE_API_KEY_ANDROID']
          : dotenv.env['FIREBASE_API_KEY_IOS'];

  final appId =
      kIsWeb
          ? dotenv.env['FIREBASE_APP_ID_WEB']
          : defaultTargetPlatform == TargetPlatform.android
          ? dotenv.env['FIREBASE_APP_ID_ANDROID']
          : dotenv.env['FIREBASE_APP_ID_IOS'];

  final projectId = dotenv.env['FIREBASE_PROJECT_ID'];
  final messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
  final storageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'];

  // Valida as variáveis do .env
  if (apiKey == null ||
      appId == null ||
      projectId == null ||
      messagingSenderId == null ||
      storageBucket == null) {
    throw Exception(
      'Alguma variável do .env está faltando. Verifique o arquivo .env.',
    );
  }

  // Inicializa o Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      projectId: projectId,
      messagingSenderId: messagingSenderId,
      storageBucket: storageBucket,
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: const FuriaApp(),
    ),
  );
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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Simula um tempo de carregamento (pode ser ajustado ou removido)
    await Future.delayed(const Duration(seconds: 2));

    // Navega para a tela de login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_furia.png',
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'FuriaVerso',
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
