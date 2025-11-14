// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Para navegação

enum AuthMode { login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.login;

  void _switchAuthMode() {
    setState(() {
      _authMode = _authMode == AuthMode.login ? AuthMode.signup : AuthMode.login;
    });
  }

  void _submitAuthForm() {

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Bem Vindo, Emilio!',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'MEU RA: 1180972',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              Card(
                color: primaryColor.withOpacity(0.9),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.verified_user, size: 40, color: Colors.white),
                      const SizedBox(height: 15),

                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black54),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),

                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.black54),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),

                      ElevatedButton(
                        onPressed: _submitAuthForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                        ),
                        child: Text(
                          _authMode == AuthMode.login ? 'Entrar' : 'Cadastrar',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          _authMode == AuthMode.login
                              ? 'Não é cadastrado? Cadastre-se'
                              : 'Já tem conta? Faça Login',
                          style: const TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}