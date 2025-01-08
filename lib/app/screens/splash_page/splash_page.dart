import 'package:flutter/material.dart';
import 'dart:async';

import 'package:netflix_clone/app/screens/home_page/home_page.dart';

import '../widget/text_widget/normal_text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Start the animation
    _controller.forward();

    // Navigate to home after a delay
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomePage()), // Replace with your home screen
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Netflix-style black background
      body: Center(
        child: FadeTransition(
            opacity: _animation,
            child: NormalText(
              title: 'NEFTLIX',
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            )

            /*Image.asset(
            'assets/png/netflix_logo.png',
            width: 150, // Adjust size as needed
          ),*/
            ),
      ),
    );
  }
}
