import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tracker_moche/components/buttons.dart';
import 'package:tracker_moche/controllers/auth_controller.dart';
import 'package:tracker_moche/functions/forms_func.dart';
import 'package:tracker_moche/models/user_model.dart';

import '../components/textfields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _celularController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Usuario user = Usuario(
        _emailController.text.trim(),
        _dniController.text.trim(),
        _nombresController.text.trim(),
        _apellidoController.text.trim(),
        _celularController.text.trim(),
        false);
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor('#cccccc'),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ))
              ],
            ),
            Container(
              height: h - 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(90),
                  // topRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Registro',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          color: HexColor("#303030"),
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      TextfieldCustom(
                        keyTpye: TextInputType.emailAddress,
                        hintText: 'Correo Electrónico',
                        prefixIcon: Icons.mail_outline,
                        controller: _emailController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Correo vacio';
                          }
                          bool correoValido = validarEmail(p0);
                          if (!correoValido) {
                            return 'Correo no valido';
                          }
                          user.email = _emailController.text.trim();
                          return null;
                        },
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
                      TextFieldPasswordCustom(
                        hintText: 'Confirma tu contraseña',
                        controller: _passwordConfirmController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Contraseña vacio';
                          }
                          bool passwordConfirmValida = validarPassword(p0);
                          if (!passwordConfirmValida) {
                            return 'Contraseña no valido';
                          }
                          return null;
                        },
                      ),
                      TextfieldCustom(
                        keyTpye: TextInputType.name,
                        hintText: 'Nombres',
                        prefixIcon: Icons.person,
                        controller: _nombresController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Nombre vacio';
                          }
                          bool nombreValido = validarNombreApellido(p0);
                          if (!nombreValido) {
                            return 'Nombre no valido';
                          }
                          setState(() {
                            _nombresController.text = palabrasMayuculas(p0);
                            user.nombres = _nombresController.text.trim();
                          });
                          return null;
                        },
                      ),
                      TextfieldCustom(
                        keyTpye: TextInputType.name,
                        hintText: 'Apellidos',
                        prefixIcon: Icons.person,
                        controller: _apellidoController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Apellido vacio';
                          }
                          bool apellidoValido = validarNombreApellido(p0);
                          if (!apellidoValido) {
                            return 'Apellido no valido';
                          }
                          setState(() {
                            _apellidoController.text = palabrasMayuculas(p0);
                            user.apellidos = _apellidoController.text.trim();
                          });
                          return null;
                        },
                      ),
                      TextfieldCustom(
                        keyTpye: TextInputType.number,
                        hintText: 'DNI',
                        prefixIcon: Icons.credit_card,
                        controller: _dniController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'DNI vacio';
                          }
                          bool dniValido = validarDni(p0);
                          if (!dniValido) {
                            return 'DNI no valido';
                          }
                          user.email = _dniController.text.trim();
                          return null;
                        },
                      ),
                      TextfieldCustom(
                        keyTpye: TextInputType.phone,
                        hintText: 'Celular',
                        prefixIcon: Icons.phone,
                        controller: _celularController,
                        validacion: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Celular vacio';
                          }
                          bool celularValido = validarCelular(p0);
                          if (!celularValido) {
                            return 'Celular no valido';
                          }
                          user.celular = _celularController.text.trim();
                          return null;
                        },
                      ),
                      LoginRegisterButton(
                        buttonText: 'Registrarte',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthController.instace.registrarUsuario(
                              user,
                              _passwordController.text.trim(),
                              _passwordConfirmController.text.trim(),
                            );
                          }
                        },
                      )
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
