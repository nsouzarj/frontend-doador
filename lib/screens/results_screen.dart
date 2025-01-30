import 'package:flutter/material.dart';
import '../widgets/result_card.dart';

class ResultsScreen extends StatefulWidget {
  final String title;
  final dynamic data;

  const ResultsScreen({super.key, required this.title, required this.data});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.data != null && widget.data['donorsByState'] != null)
              _buildSectionTitle("Doadores por Estado"),
            if (widget.data != null && widget.data['donorsByState'] != null)
              ...(_getValue(widget.data, 'donorsByState') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "Doadores em ${entry.key}",
                  value: _formatInt(entry.value),
                  icon: Icons.location_on,
                );
              }),
            if (widget.data != null &&
                widget.data['averageIMCByAgeRange'] != null)
              _buildSectionTitle("IMC Médio por Faixa Etária"),
            if (widget.data != null &&
                widget.data['averageIMCByAgeRange'] != null)
              ...(_getValue(widget.data, 'averageIMCByAgeRange') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "IMC Médio (${entry.key})",
                  value: _formatDouble(entry.value, 2),
                  icon: Icons.monitor_weight,
                );
              }),
            if (widget.data != null && widget.data['obesityPercentage'] != null)
              _buildSectionTitle("Percentual de Obesidade"),
            if (widget.data != null && widget.data['obesityPercentage'] != null)
              ResultCard(
                label: "Percentual de Obesidade (Homens)",
                value:
                    "${_formatDouble(_getValue(widget.data, 'obesityPercentage')?['Masculino'], 1) ?? 'N/A'}%",
                icon: Icons.male,
                backgroundColor: Colors.blue[50],
              ),
            if (widget.data != null && widget.data['obesityPercentage'] != null)
              ResultCard(
                label: "Percentual de Obesidade (Mulheres)",
                value:
                    "${_formatDouble(_getValue(widget.data, 'obesityPercentage')?['Feminino'], 1) ?? 'N/A'}%",
                icon: Icons.female,
                backgroundColor: Colors.pink[50],
              ),
            if (widget.data != null && widget.data['averageAgeBlood'] != null)
              _buildSectionTitle("Média de Idade por Tipo Sanguíneo"),
            if (widget.data != null && widget.data['averageAgeBlood'] != null)
              ...(_getValue(widget.data, 'averageAgeBlood') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "Idade Média (Tipo ${entry.key})",
                  value: "${_formatDouble(entry.value, 1)} anos",
                  icon: Icons.bloodtype,
                  backgroundColor: Colors.red[50],
                );
              }),
            if (widget.data != null && widget.data['possibleDonors'] != null)
              _buildSectionTitle("Possíveis Doadores por Tipo Sanguíneo"),
            if (widget.data != null && widget.data['possibleDonors'] != null)
              ...(_getValue(widget.data, 'possibleDonors') as Map)
                  .entries
                  .map((entry) {
                return ResultCard(
                  label: "Possíveis doadores (${entry.key})",
                  value: _formatInt(entry.value),
                  icon: Icons.bloodtype,
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
