import '../../models/weather_model.dart';
import '../api/api_service.dart';

class WeatherService {
  final ApiService _apiService = ApiService();

  Future<WeatherModel> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final json =
        await _apiService.getWeatherByCoordinates(latitude, longitude);

    return WeatherModel.fromJson(json);
  }

  Future<WeatherModel> getWeatherByCity(
      String cidade, String estado) async {
    final json =
        await _apiService.getWeatherByCity(cidade, estado);

    return WeatherModel.fromJson(json);
  }
}