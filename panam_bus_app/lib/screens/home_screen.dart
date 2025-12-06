import 'package:flutter/material.dart';
import 'bus_list_screen.dart';
import 'qr_scan_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel de Control"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BusListScreen()),
                );
              },
              icon: const Icon(Icons.directions_bus_filled),
              label: const Text("Ver Buses"),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QrScanScreen()),
                );
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text("Escanear QR y marcar llegada"),
            ),

          ],
        ),
      ),
    );
  }
}
