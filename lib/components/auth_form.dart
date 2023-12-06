// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shop_curse/extensions/string_extensions.dart';
import 'package:shop_curse/utils/app_routes.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

enum AuthMode { login, signUp }

class _AuthFormState extends State<AuthForm> {
  // final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.login;

  void _submitForm() {
    //Adicionado navigator por enquanto.
    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
  }

  Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 250,
        width: deviceSize.width * 0.8,
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (email) {
                  final _email = email ?? '';
                  if (_email.trim().isEmpty || !_email.isValidEmail()) {
                    return 'Informe um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onSaved: (password) => _authData['password'] = password ?? '',
                controller: _passwordController,
                validator: (password) {
                  final _password = password ?? '';
                  if (_password.isEmpty || _password.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              if (_authMode == AuthMode.signUp)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: (password) {
                    final _password = password ?? '';
                    if (_password != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  _authMode == AuthMode.login ? 'Entrar' : 'Registrar',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//*** Extensão de Validação e Email, Estudar oque é extension */


//REGEX validação Email
