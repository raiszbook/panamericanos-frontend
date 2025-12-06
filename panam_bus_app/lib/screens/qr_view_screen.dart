import 'package:flutter/material.dart';

class QRViewScreen extends StatelessWidget {
  final int busId;

  const QRViewScreen({super.key, required this.busId});

  @override
  Widget build(BuildContext context) {
    // 🔴 Ajusta el host/puerto según tu backend
    const String baseUrl = 'http://localhost:8081';
    final String qrImageUrl = '$baseUrl/api/v1/buses/$busId/qr/image';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Código QR"),
      ),
      body: Center(
        child: Image.network(
          qrImageUrl,
          width: 300,
          height: 300,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Text("QR inválido o no disponible"),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data'; // 👈 agrega esta línea

class QRViewScreen extends StatelessWidget {
  final String qrData;

  const QRViewScreen({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    try {
      bytes = base64Decode(qrData);
    } catch (_) {}

    return Scaffold(
      appBar: AppBar(title: const Text("Código QR")),
      body: Center(
        child: bytes == null
            ? const Text("QR inválido o no disponible")
            : Image.memory(bytes, width: 300, height: 300),
      ),
    );
  }
}
*/