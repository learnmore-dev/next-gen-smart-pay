
import 'package:flutter/material.dart';
import 'features/home/home_page.dart';

void main() {
  runApp(const SmartPayApp());
}

class SmartPayApp extends StatelessWidget {
  const SmartPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2457E6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const HomePage(),
    );
  }
}
