// lib/services/bus_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bus.dart';

class BusApiService {
  // 👉 CAMBIA ESTA URL A TU MS-BUS
  // Ejemplos:
  // const String _baseUrl = 'http://localhost:8080/api/v1';
  // const String _baseUrl = 'http://192.168.0.10:8080/api/v1';
  static const String _baseUrl = 'http://localhost:8081/api/v1';

  Future<List<Bus>> getAllBuses() async {
    final url = Uri.parse('$_baseUrl/buses');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      // Si el backend devuelve directamente un array [ {bus}, {bus} ]
      if (body is List) {
        return body.map((e) => Bus.fromJson(e as Map<String, dynamic>)).toList();
      }

      // Si en algún momento lo cambias a StandardResponse { message, data: [ ... ] }
      if (body is Map && body['data'] is List) {
        final list = body['data'] as List;
        return list.map((e) => Bus.fromJson(e as Map<String, dynamic>)).toList();
      }

      throw Exception('Formato de respuesta inesperado al listar buses');
    } else {
      throw Exception(
          'Error al obtener buses. Status: ${response.statusCode}');
    }
  }

  Future<Bus> getBusById(int id) async {
    final url = Uri.parse('$_baseUrl/buses/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Bus.fromJson(body as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      throw Exception('Bus no encontrado');
    } else {
      throw Exception(
          'Error al obtener bus. Status: ${response.statusCode}');
    }
  }
}
