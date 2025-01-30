import 'package:flutter/material.dart';
import '../widgets/result_card.dart';

class AverageAgeBloodScreen extends StatelessWidget {
  final dynamic data;

  const AverageAgeBloodScreen({super.key, required this.data});
  // Função auxiliar para pegar o valor de forma segura
  dynamic _getValue(Map<String, dynamic>? map, String key) {
    if (map != null && map.containsKey(key)) {
      return map[key];
    }
    return null;
  }
  // Função auxiliar para formatar um double
  String _formatDouble(dynamic value, int fractionDigits) {
    if (value == null) {
      return 'N/A';
    }
    if (value is double) {
      return value.toStringAsFixed(fractionDigits);
    }
    return 'N/A';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Média de Idade por Tipo Sanguíneo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data != null && data['averageAgeBlood'] != null)
              ...(_getValue(data, 'averageAgeBlood') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "Idade Média (Tipo ${entry.key})",
                  value: "${_formatDouble(entry.value, 1)} anos",
                  icon: Icons.bloodtype,
                  backgroundColor: Colors.red[50],
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}