import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reclaim_flutter/reclaim_flutter.dart';
import 'coupon_page.dart';
import 'package:reclaim_lollipop/screens/login.dart';
import 'dart:convert';
import 'dart:io';

String truncateProof(String jsonString) {
  String substring = "statusCode";
  int index = jsonString.indexOf(substring);
  if (index != -1) {
    jsonString = jsonString.substring(index + substring.length);
  }
  return jsonString;
}

dynamic unescapeAndDecodeJson(String jsonString) {
  String unescapedJsonString = jsonString.replaceAll(r'\', '');

  return jsonDecode(unescapedJsonString);
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
              onSuccess: (proofs) async {
                var _proofs = proofs.toString();
                int length = _proofs.length;
                var occurence = _proofs.indexOf("statusCode") - 3;
                var last = _proofs.indexOf(", owner");
                print(occurence);
                var statusCode = _proofs.substring(occurence, length - last);
                print(statusCode);
                Clipboard.setData(ClipboardData(text: statusCode));
                print(json.decode(statusCode));

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CouponPage()),
                );
                print(json.decode(json.decode(proofs.toString())));
                // print(
                //     proofs.firstWhere((element) => element == 'restuarant_id'));
                // await Clipboard.setData(ClipboardData(
                //     text: truncateProof(proofs.toString())));
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
