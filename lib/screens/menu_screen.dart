import 'package:flutter/material.dart';
import 'package:frontend/screens/average_age_blood_screen.dart';
import 'package:frontend/screens/donors_by_state_screen.dart';
import 'package:frontend/screens/imc_by_age_screen.dart';
import 'package:frontend/screens/obesity_percentage_screen.dart';
import 'package:frontend/screens/possible_donors_screen.dart';
import '../services/doador_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _doadorService = DoadorService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final donorsByState = await _doadorService.getDonorsByState();
                  final data = {
                    'donorsByState': donorsByState,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonorsByStateScreen(
                        data: data,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao buscar dados: $e'),
                    backgroundColor: Colors.red,
                  ));

                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Doadores por Estado'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final averageIMCByAgeRange = await _doadorService.getAverageIMCByAgeRange();
                  final data = {
                    'averageIMCByAgeRange': averageIMCByAgeRange,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImcByAgeScreen(
                        data: data,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao buscar dados: $e'),
                    backgroundColor: Colors.red,
                  ));

                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('IMC por Faixa Etária'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final obesityPercentage = await _doadorService.getObesityPercentage();
                  final data = {
                    'obesityPercentage': obesityPercentage.toJson(),
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ObesityPercentageScreen(
                        data: data,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao buscar dados: $e'),
                    backgroundColor: Colors.red,
                  ));

                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Percentual de Obesidade'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final averageAgeBlood = await _doadorService.getAverageAgeBloodType();
                  final data = {
                    'averageAgeBlood': averageAgeBlood,
                  };

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AverageAgeBloodScreen(
                        data: data,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao buscar dados: $e'),
                    backgroundColor: Colors.red,
                  ));

                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Idade por Tipo Sanguineo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final possibleDonors = await _doadorService.getPossibleDonors();
                  final data = {
                    'possibleDonors': possibleDonors
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PossibleDonorsScreen(
                        data: data,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao buscar dados: $e'),
                    backgroundColor: Colors.red,
                  ));

                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Possíveis Doadores'),
            ),
          ],
        ),
      ),
    );
  }
}