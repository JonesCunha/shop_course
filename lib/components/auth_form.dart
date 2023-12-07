// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/exceptions/auth_exception.dart';
import 'package:shop_curse/extensions/string_extensions.dart';
import 'package:shop_curse/models/auth.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

enum AuthMode { login, signUp }

class _AuthFormState extends State<AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool _islogin() => _authMode == AuthMode.login;
  bool _isSignUp() => _authMode == AuthMode.signUp;

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    setState(() => _isLoading = true);
    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_islogin()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
        // _showErrorDialog('Logado com Sucesso');
      } else {
        // Registrar
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }
    setState(() {
      _isLoading = false;
    });

    //Adicionado navigator por enquanto.
    // Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
  }

  void _showErrorDialog(String msg) {
    // print(msg);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          icon: Icon(Icons.error, size: 32),
          elevation: 8,
          title: Text(
            'Ocorreu um Erro!',
            textAlign: TextAlign.start,
          ),
          content: Text(
            msg,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          actions: [
            TextButton(
                //Navigator.pop já é uma função com retorno esperado pelo on pressed, nao precisa necessariamente de uma função anonima.
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar'))
          ],
        );
      },
    );
  }

  void _switchAuthMode() {
    _formKey.currentState?.reset();
    _passwordController.clear();
    _emailController.clear();
    //O metodo abaixo limpou todos os campos, reconstruindo eles, retirando os valores dos controllers da tela.
    _formKey.currentState?.build(context);
    if (_islogin()) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      primary: false,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: _islogin() ? 340 : 420,
          width: deviceSize.width * 0.8,
          padding: EdgeInsets.all(16),
          child: Form(
            //Valida o Formulario Antes de iniciar.
            // autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  controller: _emailController,
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
                if (_isSignUp())
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
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8)),
                        child: Text(
                          _authMode == AuthMode.login ? 'Entrar' : 'Registrar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                Spacer(),
                TextButton(
                    onPressed: _switchAuthMode,
                    child: _islogin()
                        ? Text('Deseja Registrar?')
                        : Text('Já possui conta?')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//*** Extensão de Validação e Email, Estudar oque é extension */


//REGEX validação Email
