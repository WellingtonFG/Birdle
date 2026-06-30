class WeatherModel {
  final String cidade;
  final String estado;
  final double temperatura;
  final double temperaturaMin;
  final double temperaturaMax;
  final int umidade;
  final double velocidadeVento;
  final String descricao;
  final String icone;
  final double latitude;
  final double longitude;

  WeatherModel({
    required this.cidade,
    required this.estado,
    required this.temperatura,
    required this.temperaturaMin,
    required this.temperaturaMax,
    required this.umidade,
    required this.velocidadeVento,
    required this.descricao,
    required this.icone,
    required this.latitude,
    required this.longitude,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cidade: json["name"] ?? "",
      estado: "",
      temperatura: (json["main"]["temp"] as num).toDouble(),
      temperaturaMin: (json["main"]["temp_min"] as num).toDouble(),
      temperaturaMax: (json["main"]["temp_max"] as num).toDouble(),
      umidade: json["main"]["humidity"] ?? 0,
      velocidadeVento: (json["wind"]["speed"] as num).toDouble(),
      descricao: json["weather"][0]["description"] ?? "",
      icone: json["weather"][0]["icon"] ?? "",
      latitude: (json["coord"]["lat"] as num).toDouble(),
      longitude: (json["coord"]["lon"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cidade": cidade,
      "estado": estado,
      "temperatura": temperatura,
      "temperaturaMin": temperaturaMin,
      "temperaturaMax": temperaturaMax,
      "umidade": umidade,
      "velocidadeVento": velocidadeVento,
      "descricao": descricao,
      "icone": icone,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}