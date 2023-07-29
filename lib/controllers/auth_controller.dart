import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracker_moche/components/snackbars.dart';
import 'package:tracker_moche/models/user_model.dart';
import 'package:tracker_moche/pages/login_screen.dart';
import 'package:tracker_moche/pages/welcome_screen.dart';

class AuthController extends GetxController {
  static AuthController instace = Get.find();
  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime? selectedDate;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      final dni = await conseguirDni();
      final isConductor = await verificarConductor(dni);
      final userName = await conseguirNombre();
      Get.offAll(() => WelcomeScreen(
            userName: userName ?? 'Nombre de usuario',
            isConductor: isConductor,
          ));
    }
  }

  bool passwordConfirmed(String password, confirmpassword) {
    if (password == confirmpassword) {
      return true;
    } else {
      return false;
    }
  }

  Future addDatos(Usuario user) async {
    await FirebaseFirestore.instance.collection('usuarios').add({
      'correo': user.email,
      'nombres': user.nombres,
      'apellidos': user.apellidos,
      'dni': user.dni,
      'celular': user.celular,
      'tipo': user.isConductor ? 'Conductor' : 'Usuario',
    });
  }

  void registrarUsuario(
    Usuario user,
    String password,
    confirmpassword,
  ) async {
    try {
      if (passwordConfirmed(password, confirmpassword)) {
        user.isConductor = await verificarConductor(user.dni);
        await auth.createUserWithEmailAndPassword(
            email: user.email, password: password);
        addDatos(user);
      } else {
        snackPasswordDistintas();
      }
    } catch (e) {
      snackErrorCrearCuenta();
    }
  }

  void loginUsuario(
    BuildContext context,
    String email,
    password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      snackInicioSesionCorrecto();
    } catch (e) {
      snackErrorInicioSesion();
    }
  }

  void cerrarSesion() {
    FirebaseAuth.instance.signOut();
  }

  Future passwordReset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      snackLinkEviado();
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          snackUsuarioNoEncontrado();
        }
      } else {
        {
          snackLinkNoEviado();
        }
      }
    }
  }

  Future<String?> conseguirNombre() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .where('correo', isEqualTo: currentUser.email)
            .get();
        if (snapshot.docs.isNotEmpty) {
          final userData = snapshot.docs.first.data();
          return userData['nombres'] as String?;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

Future<String?> conseguirDni() async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('correo', isEqualTo: currentUser.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        return userData['dni'] as String?;
      }
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<bool> verificarConductor(String? dni) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('conductores')
        .doc(dni)
        .get();

    return snapshot.exists;
  } catch (e) {
    return false;
  }
}
