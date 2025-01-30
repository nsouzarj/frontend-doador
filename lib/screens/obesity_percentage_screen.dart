import 'package:flutter/material.dart';
import '../widgets/result_card.dart';

class ObesityPercentageScreen extends StatelessWidget {
  final dynamic data;

  const ObesityPercentageScreen({super.key, required this.data});
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
      appBar: AppBar(title: const Text('Percentual de Obesidade')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data != null && data['obesityPercentage'] != null)
              ResultCard(
                label: "Percentual de Obesidade (Homens)",
                value:
                "${_formatDouble(_getValue(data, 'obesityPercentage')?['Masculino'], 1) ?? 'N/A'}%",
                icon: Icons.male,
                backgroundColor: Colors.blue[50],
              ),
            if (data != null && data['obesityPercentage'] != null)
              ResultCard(
                label: "Percentual de Obesidade (Mulheres)",
                value:
                "${_formatDouble(_getValue(data, 'obesityPercentage')?['Feminino'], 1) ?? 'N/A'}%",
                icon: Icons.female,
                backgroundColor: Colors.pink[50],
              ),
          ],
        ),
      ),
    );
  }
}