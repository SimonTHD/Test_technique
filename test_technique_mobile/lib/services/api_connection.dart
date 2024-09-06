import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api/';

  Future<User?> loginUser(String username, String password) async {
    final url = Uri.parse(baseUrl + 'token/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> registerUser(
      String username, String password, String email) async {
    final url = Uri.parse(baseUrl + 'create-user/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    return response.statusCode == 201;
  }
}
