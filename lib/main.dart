import 'package:flutter/material.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/screens/inspection_data_screen.dart';
import 'package:flutter_task/screens/login_screen.dart';
import 'package:flutter_task/screens/save_inspection_screen.dart';
import 'package:flutter_task/screens/submit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primaryColor),
      home: const LoginScreen(),
    );
  }
}
