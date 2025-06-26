import 'package:flutter/material.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // or any background color
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32), // Adjust the value for more/less curve
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
