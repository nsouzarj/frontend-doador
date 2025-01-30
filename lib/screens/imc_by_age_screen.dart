import 'package:flutter/material.dart';
import '../widgets/result_card.dart';

class ImcByAgeScreen extends StatelessWidget {
  final dynamic data;

  const ImcByAgeScreen({super.key, required this.data});
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
      appBar: AppBar(title: const Text('IMC Médio por Faixa Etária')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data != null && data['averageIMCByAgeRange'] != null)
              ...(_getValue(data, 'averageIMCByAgeRange') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "IMC Médio (${entry.key})",
                  value: _formatDouble(entry.value, 2),
                  icon: Icons.monitor_weight,
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}