import 'package:flutter/material.dart';
import '../widgets/result_card.dart';

class PossibleDonorsScreen extends StatelessWidget {
  final dynamic data;

  const PossibleDonorsScreen({super.key, required this.data});

  // Função auxiliar para pegar o valor de forma segura
  dynamic _getValue(Map<String, dynamic>? map, String key) {
    if (map != null && map.containsKey(key)) {
      return map[key];
    }
    return null;
  }
  // Função auxiliar para formatar uma int
  String _formatInt(dynamic value) {
    if (value == null) {
      return 'N/A';
    }
    if (value is int) {
      return value.toString();
    }
    return 'N/A';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Possíveis Doadores por Tipo Sanguíneo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data != null && data['possibleDonors'] != null)
              ...(_getValue(data, 'possibleDonors') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "Possíveis doadores (${entry.key})",
                  value: _formatInt(entry.value),
                  icon: Icons.bloodtype,
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}