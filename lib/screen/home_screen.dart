import 'package:flutter/material.dart';
import 'package:flutter_e6_s2/screen/login_screen.dart';
import 'package:flutter_e6_s2/screen/register_screen.dart';
import '../services/secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = false;
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await _secureStorage.readToken();
    if (mounted) {
      setState(() {
        _isLoggedIn = token != null && token.isNotEmpty;
      });
    }
  }

  void _logout() async {
    await _secureStorage.deleteCredentials();
    _checkLoginStatus(); // Met à jour l'interface
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous avez été déconnecté.')),
      );
    }
  }

  List<Widget> _buildAppBarActions() {
    if (_isLoggedIn) {
      return [
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Déconnexion',
          onPressed: _logout,
        ),
      ];
    } else {
      return [
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
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S6_S2'),
        elevation: 10.0,
        actions: _buildAppBarActions(),
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
    if (_isLoggedIn) {
      Navigator.pushNamed(context, '/message');
    } else {
      _showLoginRequiredDialog();
    }
  }

  void btUser() {
    if (_isLoggedIn) {
      Navigator.pushNamed(context, '/user');
    } else {
      _showLoginRequiredDialog();
    }
  }

  void _showLoginRequiredDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez vous connecter pour accéder à cette section.'),
        duration: Duration(seconds: 2),
      ),
    );
    // On redirige vers la page de login
    btLogin(); 
  }

  void btRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    ).then((_) => _checkLoginStatus());
  }

  void btLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    ).then((_) => _checkLoginStatus());
  }
}
