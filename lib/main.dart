import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/screens/history_screen.dart';
import 'package:restaurant_universitaire/screens/home_screen.dart';
import 'package:restaurant_universitaire/screens/login_screen.dart';
import 'package:restaurant_universitaire/screens/splash_screen.dart';
import 'package:restaurant_universitaire/theme/app_theme.dart';
import 'screens/profile_screen.dart';
import 'screens/about_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestaurantApp());
}

class RestaurantApp extends StatefulWidget {
  const RestaurantApp({super.key});

  @override
  State<RestaurantApp> createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  User? currentUser;
  bool _isReady = false;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Get the current user
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Wait for Firestore document to load
      String docId = currentUser!.email!;
      final docRef =
          FirebaseFirestore.instance.collection('userProfile').doc(docId);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        userData = docSnapshot.data();
        print('Document data: $userData');
      } else {
        print('No document found with ID: $docId');
      }
    }

    // After everything is done, update state
    if (mounted) {
      setState(() {
        _isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Universitaire Wahat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: !_isReady
          ? const SplashScreen()
          : (currentUser != null
              ? HomeScreen(
                  userData: userData,
                )
              : const LoginScreen()),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(
              userData: userData,
            ),
        '/profile': (context) => ProfileScreen(
              userData: userData,
            ),
        '/about': (context) => const AboutScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
