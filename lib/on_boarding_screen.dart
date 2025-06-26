import 'package:first_step/homedashboard.dart';
import 'package:first_step/intropages/intropage1.dart';
import 'package:first_step/intropages/intropage2.dart';
import 'package:first_step/intropages/intropage3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'components/login_page.dart';

class on_boarding_screen extends StatefulWidget {
  const on_boarding_screen({super.key});

  @override
  _OnBordingScreenState createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<on_boarding_screen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              intropage1(),
              intropage2(),
              intropage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text('skip'),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeDashboard(); // Replace with your login page
                              },
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue[800],
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text('done'),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.bounceInOut,
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue[800],
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Text('next'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}