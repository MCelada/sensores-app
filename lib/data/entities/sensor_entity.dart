import 'package:floor/floor.dart';
import 'package:sensoresapp/data/entities/user_entity.dart';

@Entity(
  tableName: 'sensores',
  foreignKeys: [
    ForeignKey(
      childColumns: ['usuario_id'],
      parentColumns: ['id'],
      entity: Usuario,
    ),
  ],
)
class Sensor {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String nombre;
  final String tipo;
  final String modelo;
  final String descripcion;

  @ColumnInfo(name: 'datasheet_url')
  final String datasheetUrl;

  @ColumnInfo(name: 'imagen_url')
  final String? imagenUrl;

  @ColumnInfo(name: 'usuario_id')
  final int usuarioId;

  Sensor({
    this.id,
    required this.nombre,
    required this.tipo,
    required this.modelo,
    required this.descripcion,
    required this.datasheetUrl,
    required this.usuarioId,
    this.imagenUrl,
  });
}
