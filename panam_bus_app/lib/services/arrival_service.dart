// lib/services/arrival_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArrivalService {
  // Ajusta el puerto si tu backend cambia (8081, etc.)
  static const String _baseUrl = 'http://localhost:8081/api/v1/buses';

  /// Envía el dato leído del QR al backend para registrar la llegada.
  static Future<String> registerArrival(String qrData) async {
    final url = Uri.parse('$_baseUrl/arrivals');

     final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'qrData': qrData}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['message'] ?? 'Llegada registrada';
    } else if (response.statusCode == 404) {
      throw Exception("Bus no encontrado para QR: $qrData");
    } else {
      throw Exception(
          "Error ${response.statusCode}: ${response.body}");
    }
  }
}