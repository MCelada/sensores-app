import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


import 'package:sensoresapp/data/entities/user_entity.dart';
import 'package:sensoresapp/data/entities/sensor_entity.dart';
import 'package:sensoresapp/data/user_dao.dart';
import 'package:sensoresapp/data/sensor_dao.dart';


part 'database.g.dart'; 


@Database(version: 1, entities: [Usuario, Sensor])
abstract class AppDatabase extends FloorDatabase {
  UsuarioDao get usuarioDao;
  SensorDao get sensorDao;
}
