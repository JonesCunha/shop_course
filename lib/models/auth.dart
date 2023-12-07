import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_curse/api/apikeys.dart';
import 'package:shop_curse/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {

  Future<void> _autenticate (String email, String password, String urlFragment) async {
    final baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${ApiKeys.apiFirebase}';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    final body = jsonDecode(response.body);

    if(body['error'] != null){
      // print(body['error']['message']);
      throw AuthException(body['error']['message']);
    }
  }

  Future<void> signup(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }

}
