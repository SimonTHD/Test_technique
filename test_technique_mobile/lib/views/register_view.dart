import 'package:flutter/material.dart';
import '../services/api_connection.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    final firstname = _firstnameController.text;
    final lastname = _lastnameController.text;

    final success = await _apiService.registerUser(username, password, email, firstname, lastname);

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Utilisateur enregistré')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur lors de l\'inscription')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            TextField(
              controller: _firstnameController,
              decoration: InputDecoration(labelText: 'Nom'),
              obscureText: true,
            ),
            TextField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: 'Prénom'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
