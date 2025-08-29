import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
