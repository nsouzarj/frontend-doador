import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/results.dart'; // Importe seus models

class DoadorService {
  static const String _baseUrl = 'http://192.168.18.5:8080/api'; // URL base correta
  static const String _uploadUrl = 'http://192.168.18.5:8080/api/doadores'; // URL para upload

  Future<bool> uploadDonors(String jsonData) async {
    try {
      final response = await http.post(
        Uri.parse(_uploadUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorBody = response.body;
        throw Exception('Falha no upload: Status Code ${response.statusCode}, corpo: $errorBody');
      }
    } catch (e) {
      throw Exception('Erro ao fazer a requisição para o back-end: $e');
    }
  }

  // Função auxiliar para converter para int com segurança
  int _safeParseInt(dynamic value) {
    if (value == null) {
      return 0; // Retorna 0 se for null
    }
    if (value is int) {
      return value;
    }
    if(value is String) {
      return int.tryParse(value) ?? 0;
    }
    if(value is double){
      return value.toInt();
    }
    return 0; // Ou outro valor padrão/erro apropriado
  }
  // Função auxiliar para converter para double com segurança
  double _safeParseDouble(dynamic value) {
    if (value == null) {
      return 0.0; // Retorna 0.0 se for null
    }
    if (value is double) {
      return value;
    }
    if(value is int) {
      return value.toDouble();
    }
    if(value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }


  Future<Map<String, int>> getDonorsByState() async {
    final response = await http.get(Uri.parse('$_baseUrl/results/state-count'));
    final decoded = json.decode(response.body);
    return Map<String, int>.from(decoded.map((key, value) => MapEntry(key, _safeParseInt(value))));
  }

  Future<Map<String, double>> getAverageIMCByAgeRange() async {
    final response = await http.get(Uri.parse('$_baseUrl/results/average-imc'));
    final decoded = json.decode(response.body);
    return Map<String, double>.from(decoded.map((key, value) => MapEntry(key, _safeParseDouble(value))));
  }

  Future<ObesityPercentage> getObesityPercentage() async {
    final response = await http.get(Uri.parse('$_baseUrl/results/obesity-percentage'));
    return ObesityPercentage.fromJson(json.decode(response.body));

  }

  Future<Map<String, double>> getAverageAgeBloodType() async {
    final response = await http.get(Uri.parse('$_baseUrl/results/average-age-blood'));
    final decoded = json.decode(response.body);
    return Map<String, double>.from(decoded.map((key, value) => MapEntry(key, _safeParseDouble(value))));
  }

  Future<Map<String, int>> getPossibleDonors() async {
    final response = await http.get(Uri.parse('$_baseUrl/results/possible-doadores'));
    final decoded = json.decode(response.body);
    return Map<String, int>.from(decoded.map((key, value) => MapEntry(key, _safeParseInt(value))));

  }
}