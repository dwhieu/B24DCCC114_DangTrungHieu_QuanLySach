import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(const QuanLySachApp());

class QuanLySachApp extends StatelessWidget {
  const QuanLySachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý sách',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
