import 'package:flutter/material.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32), 
          child: Image.asset(
            'assets/budget_bee_icon_only.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
