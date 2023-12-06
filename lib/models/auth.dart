import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_curse/apikeys/apikeys.dart';

class Auth with ChangeNotifier {

  Future<void> _autenticate (String email, String password, String urlFragment) async {
    final baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${ApiKeys.apiFirebase}';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    print(jsonDecode(response.body));

  }

  Future<void> signup(String email, String password) async {
    _autenticate(email, password, 'signUp');
  }

}
