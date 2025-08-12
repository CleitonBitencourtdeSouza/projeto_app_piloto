import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'escolha_perfil_page.dart';

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

  bool _senhaVisivel = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final user = _userController.text;
      final pass = _passController.text;

      if (user == 'admin' && pass == '1234') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('logado', true);
        await prefs.setString('usuario', user); // salva o nome do usuario

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EscolhaPerfilPage()),
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
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Digite seu usuário' : null,
              ),

              const SizedBox(height: 16),

              //Campo de senha demonstra o ícone e botão parta mostra/ocultar
              TextFormField(
                controller: _passController,
                obscureText: !_senhaVisivel, // ocultar/mostra a senha
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _senhaVisivel = !_senhaVisivel;
                      });
                    },
                  ),
                ),
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
