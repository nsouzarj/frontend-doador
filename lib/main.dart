import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';

void main() => runApp(const BloodDonorApp());

class BloodDonorApp extends StatelessWidget {
  const BloodDonorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estatistica de Doadores',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
