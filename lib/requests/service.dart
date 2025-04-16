import 'dart:convert';
import 'package:http/http.dart' as http;

class RestService {
  static Future<http.Response> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {'Content-Type': 'application/json'};
    final combinedHeaders = {...defaultHeaders, ...?headers};

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(uri, headers: combinedHeaders);
      case 'POST':
        return await http.post(uri, headers: combinedHeaders, body: jsonEncode(body));
      case 'PUT':
        return await http.put(uri, headers: combinedHeaders, body: jsonEncode(body));
      case 'DELETE':
        return await http.delete(uri, headers: combinedHeaders, body: jsonEncode(body));
      case 'PATCH':
        return await http.patch(uri, headers: combinedHeaders, body: jsonEncode(body));
      default:
        throw UnsupportedError('Método HTTP não suportado: $method');
    }
  }
}
