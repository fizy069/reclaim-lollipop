import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coupon_uikit/coupon_uikit.dart';

class Coupon extends StatelessWidget {
  final String title;
  final String description;
  final String code;

  const Coupon({
    Key? key,
    required this.title,
    required this.description,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Coupon Code: $code',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late Future<List<Coupon>> _couponFuture;

  @override
  void initState() {
    super.initState();
    _couponFuture = _fetchCoupons();
  }

  Future<List<Coupon>> _fetchCoupons() async {
    // Simulating API call delay
    return Future.delayed(Duration(milliseconds: 50), () {
      return List.generate(5, (index) {
        return Coupon(
          title: 'Coupon $index',
          description: 'Description of Coupon $index',
          code: 'nigger',
        );
      });
    });
  }

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Coupons'),
        ),
        body: Column(children: [
          FutureBuilder<List<Coupon>>(
            future: _couponFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<Coupon>? coupons = snapshot.data;
                return ListView.builder(
                  itemCount: coupons!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(coupons[index].title),
                      subtitle: Text(coupons[index].description),
                    );
                  },
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}
