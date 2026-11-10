import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0F1A),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Image.asset('assets/images/img.png', width: 160),
            SizedBox(height: 24),

            Text(
                'LEVEL UP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
                color: Colors.white
              ),

            )
          ],
        ),
      ),
    );
  }
}
