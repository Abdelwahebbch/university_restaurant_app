import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:restaurant_universitaire/screens/history_screen.dart';
import 'package:restaurant_universitaire/screens/home_screen.dart';
import 'package:restaurant_universitaire/screens/login_screen.dart';
import 'package:restaurant_universitaire/screens/splash_screen.dart';
import 'package:restaurant_universitaire/theme/app_theme.dart';
import 'screens/profile_screen.dart';
import 'screens/about_screen.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://sqjciedukstpzofrsqva.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNxamNpZWR1a3N0cHpvZnJzcXZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU2Njk3NzksImV4cCI6MjA3MTI0NTc3OX0.K5IhIXjKqeqRq2-C_15I5nGGvKNER9Si61dGUAwduvs',
  );
  runApp(RestaurantApp());
}

final supabase = Supabase.instance.client;

class RestaurantApp extends StatefulWidget {
  const RestaurantApp({super.key});

  @override
  State<RestaurantApp> createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Universitaire Wahat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _isLoading ? SplashScreen() : LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/about': (context) => const AboutScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
