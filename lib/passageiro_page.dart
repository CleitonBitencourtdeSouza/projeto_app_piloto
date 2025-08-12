import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassageiroPage extends StatefulWidget {
  const PassageiroPage({super.key});

  @override
  State<PassageiroPage> createState() => _PassageiroPageState();
}

class _PassageiroPageState extends State<PassageiroPage> {
  bool _aguardando = false;

  void _solicitarCorrida() {
    setState(() {
      _aguardando = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Corrida Solicitada! Aguardando motorista ...'),
      ),
    );
  }

  // Função de deslogar
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Remove todos os dados salvos
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route) => false, // Remove todas as rotas anterioores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do Passageiro')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _aguardando ? 'Aguardando motorista ...' : 'Olá Passageiro',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _aguardando ? null : _solicitarCorrida,
              child: const Text('Solicitar Corrida'),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: _logout, child: const Text('Sair')),
          ],
        ),
      ),
    );
  }
}
