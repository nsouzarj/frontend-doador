import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:frontend/screens/results_screen.dart';
import '../services/doador_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DoadorService _donorService = DoadorService();
  bool _isLoading = true;
  final String title = 'Estatísticas de Doadores';
  String? _data;

  @override
  void initState() {
    super.initState();
    _loadJsonFromAssets();
  }

  Future<void> _loadJsonFromAssets() async {
    try {
      setState(() => _isLoading = true);
      _data = await rootBundle.loadString('assets/data.json');
      print('Conteúdo do JSON (do assets): $_data');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar arquivo: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _uploadJsonFile() async {
    setState(() => _isLoading = true);
    try {
      if (_data != null) {
        final uploadSuccess = await _donorService.uploadDonors(_data!);

        if (uploadSuccess) {
          final decodedJson = jsonDecode(_data!);
          if (decodedJson is Map<String, dynamic>) {
            Navigator.push(
              context,
              MaterialPageRoute(
                 // builder: (context) => MenuScreen()),
                  builder: (context) => ResultsScreen(title: title, data: decodedJson)),
            );
          } else if (decodedJson is List<dynamic> && decodedJson.isNotEmpty && decodedJson[0] is Map<String, dynamic>) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuScreen()),
                 // builder: (context) => ResultsScreen(title: title, data: decodedJson[0])),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Formato do JSON inválido: Esperava um objeto ou lista de objetos')),
            );
          }


        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha no upload')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: Dados não carregados.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar para o backend: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas de Doadores')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bloodtype, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Carregar Dados do JSON'),
              onPressed: _uploadJsonFile,
            ),
          ],
        ),
      ),
    );
  }
}