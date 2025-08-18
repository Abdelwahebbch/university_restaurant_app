import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/screens/home_screen.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Restaurant Universitaire Wahat',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
