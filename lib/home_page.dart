import 'package:flutter/material.dart';
import 'package:projeto_app_piloto/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nomeUsuario = '';

  @override
  void initState() {
    super.initState();
    carregarUsuario();// Carrega o nome ao iniciar a tela
  }

  Future<void> carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('usuario') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () async {
              // Diz que a função vai esperar operações assíncronas
              final prefs =
                  await SharedPreferences.getInstance(); // Espere o acesso ao armazenamento local
              await prefs.remove('logado'); // Remove o status de logado
              await prefs.remove('usuario');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ), // volta para tela de login
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Bem-vindo, $nomeUsuario!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
