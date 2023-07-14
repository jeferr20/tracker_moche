import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class TextfieldCustom extends StatefulWidget {
  final TextInputType keyTpye;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  const TextfieldCustom(
      {super.key,
      required this.keyTpye,
      required this.hintText,
      required this.prefixIcon,
      required this.controller,
      this.onSubmitted});

  @override
  State<TextfieldCustom> createState() => _TextfieldCustomState();
}

class _TextfieldCustomState extends State<TextfieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyTpye,
        cursorColor: HexColor("#303030"),
        obscureText: false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: HexColor("#a8aaa8"),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: HexColor("#303030"),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(widget.prefixIcon),
          prefixIconColor: HexColor("#303030"),
          filled: true,
        ),
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: HexColor("#303030"),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}

class TextFieldPasswordCustom extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  const TextFieldPasswordCustom(
      {super.key,
      required this.hintText,
      required this.controller,
      this.onSubmitted});

  @override
  State<TextFieldPasswordCustom> createState() =>
      _TextFieldPasswordCustomState();
}

class _TextFieldPasswordCustomState extends State<TextFieldPasswordCustom> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: HexColor("#303030"),
        obscureText: passwordVisible,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: HexColor("#a8aaa8"),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: HexColor("#303030"),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.lock_outline),
          prefixIconColor: HexColor("#303030"),
          filled: true,
          suffixIcon: IconButton(
            color: HexColor("#303030"),
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
          alignLabelWithHint: false,
        ),
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: HexColor("#303030"),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
