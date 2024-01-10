import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}

// FLOW OF DATA:
// weather.dart > location_screen.dart > location.dart > networking.dart > loading_screen.dart > main.dart
// city_screen.dart is a feature connected to location_screen.dart