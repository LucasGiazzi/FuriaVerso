import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitedUserPage extends StatefulWidget {
  final String userId; // ID do usuário visitado

  const VisitedUserPage({super.key, required this.userId});

  @override
  State<VisitedUserPage> createState() => _VisitedUserPageState();
}

class _VisitedUserPageState extends State<VisitedUserPage> {
  final _firestore = FirebaseFirestore.instance;

  String nickname = '';
  String bio = '';
  String profileImageUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userDoc =
          await _firestore.collection('users').doc(widget.userId).get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        setState(() {
          nickname = data['nickname'] ?? 'Usuário';
          bio = data['bio'] ?? 'Sem bio disponível.';
          profileImageUrl = data['profileImageUrl'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('Usuário não encontrado.');
      }
    } catch (e) {
      print('Erro ao carregar os dados do usuário: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Carregando...'),
          backgroundColor: Colors.black,
        ),
        body: const Center(child: CircularProgressIndicator()),
        backgroundColor: Colors.black,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(nickname), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
              child:
                  profileImageUrl.isEmpty
                      ? const Icon(Icons.person, size: 50)
                      : null,
            ),
            const SizedBox(height: 16),
            Text(
              nickname,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              bio,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
