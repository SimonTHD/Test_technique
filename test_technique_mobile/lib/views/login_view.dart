import 'package:flutter/material.dart';
import '../services/api_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final Map<String, dynamic>? response = await _apiService.loginUser(username, password);
    print("response: $response");
    if (response != null && response.containsKey('access')) {
      String token = response['access'];
      print("response_token: $token");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connexion réussie !')));
      Navigator.pushReplacementNamed(context, '/projects');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur de connexion')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
