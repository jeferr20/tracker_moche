import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tracker_moche/components/buttons.dart';
import 'package:tracker_moche/components/textfields.dart';
import 'package:tracker_moche/controllers/auth_controller.dart';
import 'package:tracker_moche/functions/forms_func.dart';
import 'package:tracker_moche/pages/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor('#cccccc'),
      extendBody: true,
      body: SingleChildScrollView(
        // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.025,
            ),
            Container(
              height: h * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                      fit: BoxFit.fitHeight)),
            ),
            SizedBox(
              height: h * 0.025,
            ),
            Container(
              height: h * 0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(90),
                  // topRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 30, 25, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          color: HexColor("#303030"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextfieldCustom(
                        keyTpye: TextInputType.emailAddress,
                        hintText: 'Hola@gmail.com',
                        prefixIcon: Icons.mail_outline,
                        controller: _emailController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Correo vacio';
                          }
                          bool correoValido = EmailValidator.validate(p0);
                          if (!correoValido) {
                            return 'Correo no valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldPasswordCustom(
                        hintText: 'Contraseña',
                        controller: _passwordController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Contraseña vacio';
                          }
                          bool passwordValida = validarPassword(p0);
                          if (!passwordValida) {
                            return 'Contraseña no valido';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text('Olvidé mi contraseña',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#fec200'))))
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      LoginRegisterButton(
                        buttonText: 'Iniciar Sesión',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthController.instace.loginUsuario(
                                context,
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            text: '¿Aún no estas registrado? ',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: HexColor('#fec200')),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => const RegisterScreen());
                                  },
                                text: ' Registrate aqui',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: HexColor('#fec200')),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
