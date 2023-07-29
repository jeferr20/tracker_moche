import 'package:geolocator/geolocator.dart';

class Queja {
  final String placaVehiculo;
  final DateTime fecha;
  final String dniConductor;
  final String descripcion;
  final String emailUsuario;
  final Position ubicacion;

  Queja(this.placaVehiculo, this.fecha, this.dniConductor, this.descripcion,
      this.emailUsuario, this.ubicacion);
}
