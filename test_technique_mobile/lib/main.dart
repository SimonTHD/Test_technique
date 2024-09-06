import 'package:flutter/material.dart';
import 'package:test_technique_mobile/views/login_view.dart';
//import 'views/login_view.dart';
import 'views/register_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Technique flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginView(),
      /*routes: {
        '/register': (context) => RegisterView(),
      },*/
    );
  }
}
