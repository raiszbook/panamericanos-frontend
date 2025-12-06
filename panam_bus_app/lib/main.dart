import 'package:flutter/material.dart';
import 'screens/home_screen.dart';   // 👉 ahora abrimos nuestro menú principal

void main() {
  runApp(const PanamBusApp());
}

class PanamBusApp extends StatelessWidget {
  const PanamBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panamericanos 2027 - Transporte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red, // tus colores originales
      ),
      home: const HomeScreen(), // 👉 ahora inicia en el menú
    );
  }
}
