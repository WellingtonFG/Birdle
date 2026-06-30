import 'package:flutter/material.dart';
import '../../models/location_model.dart';
import '../../repository/location/location_repository.dart';
import '../../services/weather/weather_service.dart';
import '../home/home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final WeatherService _weatherService = WeatherService();
  final LocationRepository _locationRepository = LocationRepository();

  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  
  bool _isLoading = false;
  String _message = 'Filtre por Cidade e Estado para ter sua previsão.';

  Future<void> _pesquisar() async {
    String cidade = _cidadeController.text.trim();
    String estado = _estadoController.text.trim();

    if (cidade.isEmpty || estado.isEmpty) {
      setState(() {
        _message = 'Por favor, preencha ambos os campos.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final weather = await _weatherService.getWeatherByCity(cidade, estado);

      final locationModel = LocationModel(
        cidade: weather.cidade,
        estado: estado,
        latitude: weather.latitude,
        longitude: weather.longitude,
      );
      await _locationRepository.saveOrUpdateLocation(locationModel);

      if (!mounted) return;
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(weather: weather)),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'Localidade não encontrada. Verifique a Cidade e Estado.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Localização'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(
                labelText: 'Cidade',
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _estadoController,
              decoration: const InputDecoration(
                labelText: 'Estado (Ex: PR, SP, RJ)',
                prefixIcon: Icon(Icons.map),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: _pesquisar,
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar Previsão', style: TextStyle(fontSize: 16)),
                  ),
            if (_message.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                _message,
                style: TextStyle(color: _message.contains('não') ? Colors.red : Colors.grey[700], fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }
}