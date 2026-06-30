import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "ac875303e9858f061886b44a4a232fd5";

  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final url =
        "$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=pt_br";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao buscar clima.");
    }
  }

  Future<Map<String, dynamic>> getWeatherByCity(
      String cidade, String estado) async {
    final url =
        "$baseUrl?q=$cidade,$estado,BR&appid=$apiKey&units=metric&lang=pt_br";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Cidade não encontrada.");
    }
  }
}