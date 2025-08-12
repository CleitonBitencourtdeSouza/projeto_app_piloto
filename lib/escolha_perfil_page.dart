import 'package:flutter/material.dart';
import 'passageiro_page.dart';
import 'motorista_page.dart';

class EscolhaPerfilPage extends StatelessWidget {
  const EscolhaPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escolha seu perfil')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Você é', style: TextStyle(fontSize: 22)),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              onPressed: () {
                //Navega para a tela do passageiro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PassageiroPage(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Modo passageirro selecionada')),
                );
              },
              icon: const Icon(Icons.directions_car),
              label: const Text('Sou Passageiro'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MotoristaPage(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Modo Motorista selecionado')),
                );
              },
              icon: const Icon(Icons.local_taxi),
              label: const Text('Sou Motorista'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
