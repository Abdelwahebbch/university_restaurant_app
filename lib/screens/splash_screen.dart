import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;
    if (!mounted) return;

    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1C2B52),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(50),
                child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image(image: AssetImage("images/log.png")))),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 70),
                child: LinearProgressIndicator()),
            SizedBox(
              height: 150,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Developed by Abdelwaheb Bouchahwa",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
