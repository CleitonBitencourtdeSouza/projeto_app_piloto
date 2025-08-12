import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // gerencia dados salvos localmente
import 'login_page.dart'; // Para voltar a tela de login após o logout

class MotoristaPage extends StatefulWidget {
  const MotoristaPage({super.key});

  @override
  State<MotoristaPage> createState() => _MotoristaPageState();
}

class _MotoristaPageState extends State<MotoristaPage> {
  bool _temCorrida = false;

  //Simula que o motorista recebeu uma corrida
  void _receberCorrida() {
    setState(() {
      _temCorrida = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Nova Corrida Disponível!')));
  }

  // Aceitar a corrida
  void _aceitarCorrida() {
    setState(() {
      _temCorrida = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Corrida recusada. Aguardando chamada.')),
    );
  }

  //recusar corrida
  void _recusarCorrida() {
    setState(() {
      _temCorrida = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Corrida recusada. Aguarde nova chamada')),
    );
  }

  // Função de logout
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Limpa todos os dados salvos
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route) => false, // Remove todas as routas anteriores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Área do Motorista")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _temCorrida
                  ? 'Passageiro aguardando corrida'
                  : 'Nenhuma corrida no momento',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Se não tiver corrida, mostra botão de simular recebimento
            if (!_temCorrida)
              ElevatedButton(
                onPressed: _receberCorrida,
                child: const Text('Simular corrida recebida'),
              ),

            // se tem corrida, mostra botões aceitar e recusar
            if (_temCorrida) ...[
              ElevatedButton(
                onPressed: _aceitarCorrida,
                child: const Text('Aceitar corrida'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _receberCorrida,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Recusar corrida'),
              ),
            ],
            const SizedBox(height: 32),
            TextButton(onPressed: _logout, child: const Text('Sair')),
          ],
        ),
      ),
    );
  }
}
