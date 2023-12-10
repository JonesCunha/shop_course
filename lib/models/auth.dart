import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_curse/api/apikeys.dart';
import 'package:shop_curse/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {

  //Dados de retorno da API
  String? _idToken;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _idToken != null && isValid;
  }

  String? get token {
    return isAuth ? _idToken : null;
  }

  String? get email {
    return isAuth ? _email : null; 
  }

  String? get uid {
    return isAuth ? _uid : null;
  }


  Future<void> _authenticate (String email, String password, String urlFragment) async {
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
    } else {
      _idToken = body['idToken'];
      _email = body['email'];
      _uid = body['localID'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
    }
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

}
