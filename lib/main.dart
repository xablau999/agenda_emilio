// lib/main.dart (Versão de Contingência)
import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(const AgendaEmilioApp());
}

class AgendaEmilioApp extends StatelessWidget {
  const AgendaEmilioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Emilio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF673AB7),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: const Color(0xFFFF9800), // 
          background: const Color(0xFFF3F0F7), //
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        ),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}