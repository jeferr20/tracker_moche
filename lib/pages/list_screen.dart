import 'package:flutter/material.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Aqui ira la lista de conductores'),
    );
  }
}
