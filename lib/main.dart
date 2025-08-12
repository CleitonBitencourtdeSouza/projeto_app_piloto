import 'package:flutter/material.dart';
import 'package:projeto_app_piloto/home_page.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necessario para usar SharedPreferences no main
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('logado') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Piloto',
      home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
