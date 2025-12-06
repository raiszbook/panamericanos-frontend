// lib/screens/bus_list_screen.dart
import 'package:flutter/material.dart';
import '../models/bus.dart';
import '../services/bus_api_service.dart';
import 'bus_detail_screen.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({super.key});

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  final BusApiService _apiService = BusApiService();
  late Future<List<Bus>> _futureBuses;

  @override
  void initState() {
    super.initState();
    _futureBuses = _apiService.getAllBuses();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureBuses = _apiService.getAllBuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Buses - Panamericanos 2027'),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Bus>>(
          future: _futureBuses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Ocurrió un error al cargar los buses:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final buses = snapshot.data ?? [];

            if (buses.isEmpty) {
              return const Center(
                child: Text('No hay buses registrados.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: buses.length,
              itemBuilder: (context, index) {
                final bus = buses[index];

                final estadoActivo = bus.estadoRegistro ?? true;
                final estadoText = estadoActivo ? 'Activo' : 'Inactivo';
                final estadoColor =
                    estadoActivo ? Colors.green : Colors.red;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.directions_bus,
                      ),
                    ),
                    title: Text(
                      bus.placa,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (bus.categoria != null)
                          Text('Categoría: ${bus.categoria}'),
                        if (bus.nroPasajero != null)
                          Text('Pasajeros: ${bus.nroPasajero}'),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          estadoText,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: estadoColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BusDetailScreen(bus: bus),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
