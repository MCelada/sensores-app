import 'package:floor/floor.dart';
import 'package:sensoresapp/data/entities/sensor_entity.dart';

@dao
abstract class SensorDao {
  @insert
  Future<void> insertSensor(Sensor sensor);
  
  @update
  Future<void> updateSensor(Sensor sensor);

  @Query('SELECT * FROM sensores WHERE tipo = :tipo')
  Future<List<Sensor>> findByTipo(String tipo);
}
