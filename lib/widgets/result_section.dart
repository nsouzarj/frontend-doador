import 'package:flutter/material.dart';
import '../models/results.dart';
import 'result_card.dart';

class ResultSection extends StatelessWidget {
  final String title;
  final dynamic data;

  const ResultSection({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            if (data is Map)
              ...data.entries.map((entry) => ResultCard(
                label: entry.key,
                value: entry.value.toString(),
              )),
            if (data is ObesityPercentage)
              Column(
                children: [
                  ResultCard(
                    label: 'Masculino',
                    value: '${data.male.toStringAsFixed(1)}%',
                  ),
                  ResultCard(
                    label: 'Feminino',
                    value: '${data.female.toStringAsFixed(1)}%',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}