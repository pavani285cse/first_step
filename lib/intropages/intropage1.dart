import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class intropage1 extends StatelessWidget {
  const intropage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation
          Lottie.asset(
            'assets/bee.json',
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),
          
          // Title
          const Text(
            'Welcome to BudgetBee',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
            ),
          ),
          
          const SizedBox(height: 15),

          // Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Track your expenses and save smarter!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
