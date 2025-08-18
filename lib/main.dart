import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/screens/home_screen.dart';
import 'package:restaurant_universitaire/screens/splash_screen.dart';
import 'package:restaurant_universitaire/theme/app_theme.dart';

void main() {
  runApp(const RestaurantApp());
}
//
// class RestaurantApp extends StatelessWidget {
//   const RestaurantApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Restaurant Universitaire Wahat',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       home: const HomeScreen(),
//     );
//   }
// }

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
      home: _isLoading ? SplashScreen() : HomeScreen(),
    );
  }
}
