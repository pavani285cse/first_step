import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class intropage3 extends StatelessWidget {
  const intropage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          Lottie.asset(
            'assets/bee.json',
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),

        
          const Text(
            'Set Goals, Save Smarter',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
            ),
          ),

          const SizedBox(height: 15),

      
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Turn your dreams into reality by planning and tracking your financial goals.',
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
