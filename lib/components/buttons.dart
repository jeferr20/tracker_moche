import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CompartirUbiacionBoton extends StatelessWidget {
  final Function()? onPressed;
  final bool isSharing;
  const CompartirUbiacionBoton(
      {super.key, this.onPressed, required this.isSharing});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        height: h / 15,
        width: w / 1.8,
        decoration: BoxDecoration(
          color: HexColor('#fec200'),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.share_location,
              color: HexColor('#ffffff'),
            ),
            Text(
              isSharing ? 'Dejar de compartir' : 'Compartir ubiación',
              style: GoogleFonts.poppins(
                color: HexColor('#ffffff'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginRegisterButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  const LoginRegisterButton(
      {super.key, this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          height: h / 15,
          width: w / 1.8,
          decoration: BoxDecoration(
            color: HexColor('#fec200'),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              color: HexColor('#ffffff'),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}
