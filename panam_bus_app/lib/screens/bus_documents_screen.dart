import 'package:flutter/material.dart';
import '../services/document_api_service.dart';

class BusDocumentsScreen extends StatefulWidget {
  final int busId;
  final String placa;

  const BusDocumentsScreen({super.key, required this.busId, required this.placa});

  @override
  State<BusDocumentsScreen> createState() => _BusDocumentsScreenState();
}

class _BusDocumentsScreenState extends State<BusDocumentsScreen> {
  final api = DocumentApiService();
  late Future<List<dynamic>> docsFuture;

  @override
  void initState() {
    super.initState();
    docsFuture = api.getDocuments(widget.busId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Documentos del bus ${widget.placa}"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: docsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final docs = snapshot.data ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text("Sin documentos"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.file_present),
                  title: Text(d["nombreDocumento"] ?? "Sin nombre"),
                  subtitle: Text("Tipo: ${d["tipoDocumento"] ?? '-'}"),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
