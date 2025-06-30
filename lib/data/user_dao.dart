import 'package:floor/floor.dart';
import 'package:sensoresapp/data/entities/user_entity.dart';

@dao
abstract class UsuarioDao {
  @insert
  Future<void> insertUsuario(Usuario usuario);

  @Query('SELECT * FROM usuarios WHERE nombre = :nombre')
  Future<Usuario?> findByNombre(String nombre);

  @Query('SELECT * FROM usuarios')
  Future<List<Usuario>> findAllUsuarios();
}
