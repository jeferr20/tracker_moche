import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tracker_moche/components/buttons.dart';
import 'package:tracker_moche/controllers/auth_controller.dart';

import '../components/textfields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _celularController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de usuario',
          style: GoogleFonts.poppins(
              fontSize: 30,
              color: HexColor('#fec200'),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: HexColor('#fec200')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              TextfieldCustom(
                  keyTpye: TextInputType.emailAddress,
                  hintText: 'Correo Electrónico',
                  prefixIcon: Icons.mail_outline,
                  controller: _emailController),
              TextFieldPasswordCustom(
                  hintText: 'Contraseña', controller: _passwordController),
              TextFieldPasswordCustom(
                  hintText: 'Confirma tu contraseña',
                  controller: _passwordConfirmController),
              TextfieldCustom(
                  keyTpye: TextInputType.name,
                  hintText: 'Nombres',
                  prefixIcon: Icons.person,
                  controller: _nombresController),
              TextfieldCustom(
                  keyTpye: TextInputType.name,
                  hintText: 'Apellidos',
                  prefixIcon: Icons.person,
                  controller: _apellidoController),
              TextfieldCustom(
                  keyTpye: TextInputType.number,
                  hintText: 'DNI',
                  prefixIcon: Icons.credit_card,
                  controller: _dniController),
              TextfieldCustom(
                  keyTpye: TextInputType.phone,
                  hintText: 'Celular',
                  prefixIcon: Icons.phone,
                  controller: _celularController),
              LoginRegisterButton(
                buttonText: 'Registrarte',
                onPressed: () {
                  AuthController.instace.registrarUsuario(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _passwordConfirmController.text.trim(),
                      _nombresController.text.trim(),
                      _apellidoController.text.trim(),
                      _dniController.text.trim(),
                      _celularController.text.trim());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
