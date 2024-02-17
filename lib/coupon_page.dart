import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:coupon_uikit/coupon_uikit.dart';

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
    return Future.delayed(Duration(milliseconds: 50), () {
      return List.generate(5, (index) {
        return Coupon(
          title: 'Coupon $index',
          discount: 'Description of Coupon $index',
          code: 'Redeem',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Coupons'),
      ),
      body: FutureBuilder<List<Coupon>>(
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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5,10,5,5),
                  child: coupons[index],
                ); // Display Coupon directly
              },
            );
          }
        },
      ),
    );
  }
}

class Coupon extends StatelessWidget {
  final String title;
  final String discount;
  final String code;

  const Coupon({
    Key? key,
    required this.title,
    required this.discount,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.orange, // Set the border color here
          width: 1.0, // Set the border width here
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[200],
        // color: Colors.white,
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  // color : Colors.white
                ),
              ),
              Text(
                '${discount}% OFF',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.red, // Change this to your desired button color
            ),
            child: Text(
              code,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
