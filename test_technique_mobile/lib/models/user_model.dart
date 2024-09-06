import 'dart:async';

class User {
  final String refresh;
  final String access;

  User({
    required this.refresh,
    required this.access,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      refresh: json['refresh'],
      access: json['access'],
    );
  }
}
