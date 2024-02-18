// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reclaim_flutter/reclaim_flutter.dart';
import 'package:reclaim_lollipop/screens/coupon_page.dart';
import 'package:reclaim_lollipop/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class jsondata {
  final String city;
  final String Orderdate;
  final String Category;
  final String OrderDay;

  jsondata(
      {required this.city,
      required this.Orderdate,
      required this.Category,
      required this.OrderDay});

  factory jsondata.fromJson(Map<String, dynamic> json) {
    return jsondata(
      city: json['city'],
      Orderdate: json['Orderdate'],
      Category: json['Category'],
      OrderDay: json['OrderDay'],
    );
  }
}

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  void writetoFile(String data) async {
    var myFile = File('file.txt');
    myFile.writeAsString(data);
  }

  Future<http.Response> putrequest(String data) {
  
    jsondata _jsondata = jsonDecode(data);
    return http.post(Uri.parse('localhost:3000/userData'), body: <String, String>{
      "city": _jsondata.city,
      "Orderdate": _jsondata.Orderdate,
      "Category": _jsondata.Category,
      "OrderDay": _jsondata.OrderDay,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: ReclaimSwiggy(

              onClaimStateChange: (status) =>
                  print('Status changed to : $status'),
              requestedProofs: [
                SwiggyRequestedProof(
                  url: 'https://www.swiggy.com/dapi/order/all?order_id=',
                  loginUrl: 'https://www.swiggy.com/auth',
                  loginCookies: ['_session_tid'],
                ),
              ],
              title: "Swiggy",
              subTitle: "Prove that you are a swiggy user",
              cta: "Prove",
              onSuccess: (proofs) {
                var _proofs = proofs.toString();
                int length = _proofs.length;
                var occurence = _proofs.indexOf("statusCode") - 3;
                var last = _proofs.indexOf(", owner");
                // print(occurence);
                var statusCode = _proofs.substring(occurence, length - last);
                // print(statusCode);
                String unescapedJsonString = statusCode.replaceAll(r'\', '');
                 print(unescapedJsonString);
                putrequest(unescapedJsonString);
                print(jsonEncode(unescapedJsonString));

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CouponPage()),
                );
              },
              onFail: (Exception e) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                print('Error: $e');
              },
            ),
          );
        },
      ),
    );
  }
}