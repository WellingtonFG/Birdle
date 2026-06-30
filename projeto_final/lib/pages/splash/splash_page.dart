import 'package:flutter/material.dart';
import '../../models/location_model.dart';
import '../../models/weather_model.dart';
import '../../repository/location/location_repository.dart';
import '../../services/location/location_service.dart';
import '../../services/weather/weather_service.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();
  final LocationRepository _locationRepository = LocationRepository();

  @override
  void initState() {
    super.initState();
    _fluxoInicializacao();
  }

  Future<void> _fluxoInicializacao() async {
    await Future.delayed(const Duration(seconds: 2)); // Tempo para exibir a splash

    try {
      // 1. Tenta obter geolocalização do GPS
      final position = await _locationService.getCurrentLocation();
      final endereco = await _locationService.getAddress(position.latitude, position.longitude);
      
      final locationModel = LocationModel(
        cidade: endereco['cidade'] ?? '',
        estado: endereco['estado'] ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // 2. Salva ou atualiza no banco SQLite se mudou
      await _locationRepository.saveOrUpdateLocation(locationModel);

      // 3. Busca o clima via coordenadas
      final weather = await _weatherService.getWeatherByCoordinates(position.latitude, position.longitude);

      _irParaHome(weather);
    } catch (e) {
      // Fallback: Se falhar ou for negado, tenta buscar a última do banco
      final lastLocation = await _locationRepository.getLastLocation();
      if (lastLocation != null) {
        try {
          final weather = await _weatherService.getWeatherByCity(lastLocation.cidade, lastLocation.estado);
          _irParaHome(weather);
          return;
        } catch (_) {}
      }
      // Se não tiver GPS e nem histórico no banco, vai para a tela de busca manual
      _irParaBusca();
    }
  }

  void _irParaHome(WeatherModel weather) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(weather: weather)),
    );
  }

  void _irParaBusca() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_queue, size: 100, color: Colors.white),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 10),
            Text(
              'Carregando Previsão...',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}