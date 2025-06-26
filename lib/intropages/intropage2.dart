import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class intropage2 extends StatelessWidget {
  const intropage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Animation
          Lottie.asset(
            'assets/bee.json',
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),

          // Title
          const Text(
            'Understand Your Spending',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
            ),
          ),

          const SizedBox(height: 15),

          // Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Get insights with graphs and breakdowns to help you manage better.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
