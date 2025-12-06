import 'dart:convert';
import 'package:http/http.dart' as http;

class DocumentApiService {
  static const String baseUrl = "http://localhost:8081/api/v1";

  Future<List<dynamic>> getDocuments(int busId) async {
    final url = Uri.parse('$baseUrl/buses/$busId/documents');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      if (body is List) {
        return body;
      }
      if (body is Map && body['data'] is List) {
        return body['data'] as List;
      }
      throw Exception('Formato inesperado de documentos');
    }

    throw Exception('Error al obtener documentos. Status: ${res.statusCode}');
  }
}