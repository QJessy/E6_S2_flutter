import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter'), elevation: 10.0),
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
}
