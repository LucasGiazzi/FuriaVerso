import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'visited_user.dart'; // Importa a página de visualização do perfil

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchUserByNickname() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite um nickname.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Busca exata pelo nickname
      final results =
          await FirebaseFirestore.instance
              .collection('users')
              .where('nickname', isEqualTo: query) // Busca exata
              .get();

      if (results.docs.isNotEmpty) {
        final user = results.docs.first;
        final userId = user.id;

        // Redireciona para a página de visualização do perfil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitedUserPage(userId: userId),
          ),
        );
      } else {
        // Exibe mensagem se o nickname não for encontrado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao buscar usuário.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Usuários'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Digite o nickname',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchUserByNickname, // Chama a função de busca
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Pesquisar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Em Desenvolvimento",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
