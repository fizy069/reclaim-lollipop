import 'package:flutter/material.dart';
import 'package:reclaim_flutter/reclaim_flutter.dart';
import 'package:reclaim_lollipop/screens/coupan_page.dart';
import 'package:reclaim_lollipop/screens/login.dart';
import 'dart:developer';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1, // Only one item
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CoupanPage()),
                );
                print(proofs[0].proof);
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
