import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'views/projects_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Technique Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/projects': (context) => const ProjectsView(),
      },
    );
  }
}
