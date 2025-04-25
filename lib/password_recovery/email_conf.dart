import 'package:flutter/material.dart';
import 'package:furiaverso_aplicativo/password_recovery/change_pass.dart';
import 'forgot_pass.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key});

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Conteúdo principal
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 120),

                    // Título
                    const Text(
                      'Código enviado com sucesso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Subtítulo
                    const Text(
                      'Insira no campo abaixo o código de verificação enviado para seu email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 40),

                    // Campo de Código
                    TextFormField(
                      controller: _codeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Código de Verificação',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o código de verificação';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Botão Enviar
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const ChangePasswordScreen(),
                            ),
                          );

                          // Lógica para verificar o código
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nota
                    const Text(
                      'Não esqueça de verificar a pasta de Spam caso não encontre o email na sua caixa de entrada',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Ícone de Voltar
          Positioned(
            top: 50, // Ajuste para posicionar mais abaixo
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                ); // Voltar para a tela anterior
              },
            ),
          ),
        ],
      ),
    );
  }
}
