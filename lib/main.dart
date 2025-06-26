import 'package:first_step/billrem.dart';
import 'package:first_step/homedashboard.dart';
import 'package:flutter/material.dart';
import 'package:first_step/on_boarding_screen.dart';

void main() {
  runApp(MoneyManagementApp());
}

class MoneyManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetBee',
      theme: ThemeData.dark (),
      home: on_boarding_screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



