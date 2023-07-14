import 'package:email_validator/email_validator.dart';
import 'package:password_strength/password_strength.dart';
import '../components/snackbars.dart';

bool validarEmail(String value) {
  bool valido = EmailValidator.validate(value);
  if (!valido) {
    snackCorreoNoValido();
    return false;
  }
  return true;
}

bool validarPassword(String value) {
  double contraFuerte = estimatePasswordStrength(value.trim());
  if (contraFuerte < 0.1 && value.length < 6) {
    snackContraNoValida();
    return false;
  } else if (value.length < 6) {
    snackContraCorta();
    return false;
  } else if (contraFuerte < 0.1) {
    snackContraDebil();
    return false;
  }
  return true;
}

bool validarNombreApellido(String value) {
  bool nombreValido = validarNombreCompleto(value);
  if (!nombreValido) {
    snackNombreNoValido();
    return false;
  }
  return true;
}

bool validarNombreCompleto(String nombreCompleto) {
  RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
  return regex.hasMatch(nombreCompleto);
}

String palabrasMayuculas(String text) {
  List<String> nombre = text.split(' ');
  for (int i = 0; i < nombre.length; i++) {
    if (nombre[i].isNotEmpty) {
      nombre[i] = nombre[i][0].toUpperCase() + nombre[i].substring(1);
    }
  }
  String nombreMayuscula = nombre.join(' ');
  return nombreMayuscula;
}

bool validarCelular(String numero) {
  if (numero.length == 9 && numero.startsWith('9')) {
    return true; // Número de teléfono válido
  } else {
    return false; // Número de teléfono no válido
  }
}

bool validarDni(String numero) {
  if (numero.length == 8) {
    return true;
  } else {
    return false;
  }
}
