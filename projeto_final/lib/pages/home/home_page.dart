import 'package:flutter/material.dart';
import '../../models/weather_model.dart';
import '../search/search_page.dart';
import '../splash/splash_page.dart';

class HomePage extends StatelessWidget {
  final WeatherModel weather;

  const HomePage({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cidade.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SplashPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weather.descricao.toUpperCase(),
                style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.icone}@2x.png',
                    width: 90,
                    height: 90,
                    errorBuilder: (_, __, ___) => const Icon(Icons.wb_sunny, size: 80, color: Colors.orange),
                  ),
                  Text(
                    '${weather.temperatura.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildWeatherItem(Icons.air, 'Velocidade do Vento', '${weather.velocidadeVento} m/s'),
                      const Divider(height: 25),
                      _buildWeatherItem(Icons.arrow_downward, 'Mínima do Dia', '${weather.temperaturaMin.toStringAsFixed(1)}°C'),
                      const Divider(height: 25),
                      _buildWeatherItem(Icons.arrow_upward, 'Máxima do Dia', '${weather.temperaturaMax.toStringAsFixed(1)}°C'),
                      const Divider(height: 25),
                      _buildWeatherItem(Icons.water_drop, 'Umidade do Ar', '${weather.umidade}%'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherItem(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}