import 'package:flutter/material.dart';
import 'package:flutter_e6_s2/screen/login_screen.dart';
import 'package:flutter_e6_s2/screen/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S6_S2'),
        elevation: 10.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: btLogin,
              child: const Text('Connexion'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: btRegister,
              child: const Text('Inscription'),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: btMessage,
                child: const Text('Voir la liste des messages'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: btUser,
                child: const Text('Voir la liste des utilisateurs'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void btMessage() {
    Navigator.pushNamed(context, '/message');
  }

  void btUser() {
    Navigator.pushNamed(context, '/user');
  }

  void btRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void btLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
