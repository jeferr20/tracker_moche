import 'package:flutter/material.dart';

class MultasScreen extends StatelessWidget {
  const MultasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('Registrar una multa'), Text('Mis multas registradas')],
      ),
    );
  }
}
