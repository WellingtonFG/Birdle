import '../database/database_helper.dart';
import '../../models/location_model.dart';

class LocationRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> saveOrUpdateLocation(LocationModel location) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('location', limit: 1);

    if (maps.isEmpty) {
      // Se o banco estiver vazio, salva a localização atual
      await db.insert('location', location.toMap());
    } else {
      // Se já houver um registro, verifica se a cidade ou estado mudaram
      LocationModel current = LocationModel.fromMap(maps.first);
      
      if (current.cidade != location.cidade || current.estado != location.estado) {
        await db.update(
          'location',
          {
            'cidade': location.cidade,
            'estado': location.estado,
            'latitude': location.latitude,
            'longitude': location.longitude,
          },
          where: 'id = ?',
          whereArgs: [current.id],
        );
      }
    }
  }

  Future<LocationModel?> getLastLocation() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('location', limit: 1);
    
    if (maps.isNotEmpty) {
      return LocationModel.fromMap(maps.first);
    }
    return null;
  }
}