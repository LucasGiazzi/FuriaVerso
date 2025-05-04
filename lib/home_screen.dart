import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'login.dart';
import 'search_page.dart'; // Importa a página de pesquisa
import 'profile_page.dart';
import 'package:intl/intl.dart'; // Para formatar data e hora

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // Define o índice inicial (Home)
  final TextEditingController _postController = TextEditingController();

  // Lista de páginas para navegação
  final List<Widget> _pages = [
    const SearchPage(), // Página de pesquisa
    const HomeScreenContent(), // Conteúdo da Home
    const ProfilePage(), // Página de perfil
  ];

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  Future<void> _addPost(String text) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Recupera o nickname e avatar do usuário a partir do Firestore
    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

    final nickname = userDoc.data()?['nickname'] ?? 'Anônimo';
    final avatar = userDoc.data()?['profileImageUrl'] ?? '';

    // Adiciona a postagem com o nickname e avatar
    await FirebaseFirestore.instance.collection('posts').add({
      'text': text,
      'author': nickname, // Salva o nickname
      'avatar': avatar, // Salva o avatar
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _showPostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Nova Postagem',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _postController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'O que você está pensando?',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_postController.text.isNotEmpty) {
                  await _addPost(_postController.text.trim());
                  _postController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Postar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.logout(); // Faz logout do Firebase
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _pages[_currentIndex], // Exibe a página correspondente ao índice
          Positioned(
            bottom: 80, // Posição acima do botão de navegação
            right: 16, // Posição no canto direito
            child: FloatingActionButton(
              onPressed: _showPostDialog,
              backgroundColor: Colors.white,
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Atualiza o índice ao clicar em um botão
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Substitui o botão de configurações
            label: 'Pesquisar', // Botão de pesquisa
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

// Conteúdo da Home (separado para facilitar a navegação)
class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Desconhecido';
    final dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('posts')
              .orderBy('timestamp', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'Nenhuma postagem ainda.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final data = post.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          data['avatar'] != null && data['avatar'].isNotEmpty
                              ? (data['avatar'].startsWith('assets/')
                                      ? AssetImage(data['avatar'])
                                      : NetworkImage(data['avatar']))
                                  as ImageProvider
                              : const AssetImage(
                                'assets/images/default_avatar.png',
                              ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['author'] ?? 'Anônimo',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['text'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formatTimestamp(data['timestamp']),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}