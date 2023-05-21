import 'package:flutter/material.dart';

class DisplayMensaje extends StatelessWidget {
  final String mensaje;

  const DisplayMensaje({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        mensaje,
        textAlign: TextAlign.center,
      ),
    );
  }
}
