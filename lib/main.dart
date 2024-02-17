import 'package:flutter/material.dart';
import 'coupon_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Coupons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CouponPage(),
    );
  }
}
