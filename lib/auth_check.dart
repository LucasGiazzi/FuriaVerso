import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'login.dart';
import 'home_screen.dart'; // Substitua pela tela principal do seu app

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // Exibe uma tela de carregamento enquanto verifica o estado de autenticação
    if (authService.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Redireciona com base no estado de autenticação
    if (authService.usuario == null) {
      return const LoginScreen(); // Usuário não autenticado
    } else {
      return const HomeScreen(); // Usuário autenticado
    }
  }
}
