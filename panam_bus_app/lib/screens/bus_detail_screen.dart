// lib/screens/bus_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/bus.dart';
import 'qr_view_screen.dart'; // 👈 agrega este import
import 'bus_documents_screen.dart';   // 👈 agrega esta línea


class BusDetailScreen extends StatelessWidget {
  final Bus bus;

  const BusDetailScreen({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final estadoActivo = bus.estadoRegistro ?? true;
    final estadoText = estadoActivo ? 'Activo' : 'Inactivo';
    final estadoColor = estadoActivo ? Colors.green : Colors.red;

    const String baseUrl = 'http://localhost:8081/api/v1/buses';
    final fotoApiUrl = '$baseUrl/${bus.codBus}/photo';

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus ${bus.placa}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(
                        Icons.directions_bus,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        bus.placa,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(
                        estadoText,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: estadoColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // 👉 FOTO DEL BUS
                if (bus.fotoUrl != null && bus.fotoUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      fotoApiUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('>>> ERROR cargando FOTO bus ${bus.codBus}: $error');
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(child: Text("No se pudo cargar la foto")),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 20),
                _infoRow('Código', bus.codBus.toString()),
                _infoRow('Color', bus.color ?? '-'),
                _infoRow('Branding', bus.brandin ?? '-'),
                _infoRow('Motor', bus.motor ?? '-'),
                _infoRow(
                    'Nro. pasajeros',
                    bus.nroPasajero != null
                        ? bus.nroPasajero.toString()
                        : '-'),
                _infoRow(
                    'Llantas', bus.llantas != null ? bus.llantas.toString() : '-'),
                _infoRow('GPS', (bus.gps ?? false) ? 'Sí' : 'No'),
                _infoRow('Gasolina', (bus.gasolina ?? false) ? 'Sí' : 'No'),
                _infoRow('Gas', (bus.gas ?? false) ? 'Sí' : 'No'),
                _infoRow('Estado físico', bus.estadoFisico ?? '-'),
                _infoRow('Categoría', bus.categoria ?? '-'),
                const SizedBox(height: 20),
                // 👉 Más adelante aquí agregamos:
                // - Foto del bus (fotoUrl)
                // - Botón para ver QR
                // 👉 VER QR
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QRViewScreen(busId: bus.codBus),   // 👈 solo pasamos el ID
                      ),
                    );
                  },
                  icon: const Icon(Icons.qr_code_2),
                  label: const Text('Ver QR'),
                ),
                // - Navegación a Documentos
                // 👉 DOCUMENTOS DEL BUS
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BusDocumentsScreen(
                          busId: bus.codBus,
                          placa: bus.placa,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.folder),
                  label: const Text("Documentos del bus"),
                ),
                // - Navegación a Asignaciones
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  
}
