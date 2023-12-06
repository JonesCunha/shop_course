import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAin9RDDC5URWlFqpAeGoEiiczBuhFI5iU';

  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    print(jsonDecode(response.body));
  }

}
