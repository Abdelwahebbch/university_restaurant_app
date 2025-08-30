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
import 'package:restaurant_universitaire/models/student_model.dart';

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
  Student? student;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<Student?> fetchStudent() async {
    final uid = FirebaseAuth.instance.currentUser?.email;
    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('userProfile')
        .doc(uid)
        .get();

    if (!doc.exists) return Student.emptyStudent();
    var data = doc.data();
    return Student.fromFireStore(data!);
  }

  Future<void> _initialize() async {
    currentUser = FirebaseAuth.instance.currentUser;

    student = await fetchStudent();

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
                  student: student!,
                )
              : const LoginScreen()),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(
              student: student!,
            ),
        '/profile': (context) => ProfileScreen(
              student: student!,
            ),
        '/about': (context) => const AboutScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
