import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: HexColor("#ffffff"),
        child: Image.asset('assets/logo.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.25));
  }
}
