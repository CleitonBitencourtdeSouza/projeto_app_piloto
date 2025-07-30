import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String? _erroMensagem;

  void _login() {
    if (_formKey.currentState!.validate()) {
      final user = _userController.text;
      final pass = _passController.text;

      if (user == 'admin' && pass == '1234') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          _erroMensagem = 'Usuario ou senha incorretos';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(labelText: 'Usuário'),
                validator: (value) =>
                    value!.isEmpty ? 'Digite seu usuário' : null,
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Digite sua senha' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _login, child: const Text('Entrar')),

              if (_erroMensagem != null) ...[
                const SizedBox(height: 16),
                Text(
                  _erroMensagem!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
