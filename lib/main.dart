import 'package:flutter/material.dart';
import 'package:reclaim_lollipop/screens/login.dart';
import 'screens/coupon_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home:  LoginScreen(),
    );
  }
}
