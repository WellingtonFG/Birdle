class LocationModel {
  final int? id;
  final String cidade;
  final String estado;
  final double latitude;
  final double longitude;

  LocationModel({
    this.id,
    required this.cidade,
    required this.estado,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "cidade": cidade,
      "estado": estado,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map["id"],
      cidade: map["cidade"],
      estado: map["estado"],
      latitude: map["latitude"],
      longitude: map["longitude"],
    );
  }
}