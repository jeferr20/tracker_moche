import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tracker_moche/components/buttons.dart';
import 'package:tracker_moche/components/textfields.dart';
import 'package:tracker_moche/controllers/auth_controller.dart';
import 'package:tracker_moche/pages/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Get.put(AuthController());
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/logo.jpg',
              height: h * 0.30,
            ),
            SizedBox(
              height: 50,
            ),
            TextfieldCustom(
                keyTpye: TextInputType.emailAddress,
                hintText: 'Hola@gmail.com',
                prefixIcon: Icons.mail_outline,
                controller: _emailController),
            SizedBox(
              height: 15,
            ),
            TextFieldPasswordCustom(
                hintText: 'Contraseña', controller: _passwordController),
            SizedBox(
              height: 15,
            ),
            LoginRegisterButton(
              buttonText: 'Iniciar Sesión',
              onPressed: () {
                AuthController.instace.loginUsuario(
                    context,
                    _emailController.text.trim(),
                    _passwordController.text.trim());
              },
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                  text: '¿Aún no estas registrado? ',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: HexColor('#fec200')),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => const RegisterScreen());
                        },
                      text: ' Registrate aqui',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: HexColor('#fec200')),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
