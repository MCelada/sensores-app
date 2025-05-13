import 'package:floor/floor.dart';

@Entity(tableName: 'usuarios')
class Usuario {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String nombre;
  final String password;

  Usuario({this.id, required this.nombre, required this.password});
}
