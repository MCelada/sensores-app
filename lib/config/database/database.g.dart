// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UsuarioDao? _usuarioDaoInstance;

  SensorDao? _sensorDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `usuarios` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombre` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sensores` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombre` TEXT NOT NULL, `tipo` TEXT NOT NULL, `modelo` TEXT NOT NULL, `descripcion` TEXT NOT NULL, `datasheet_url` TEXT NOT NULL, `imagen_url` TEXT, `usuario_id` INTEGER NOT NULL, FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
  }

  @override
  SensorDao get sensorDao {
    return _sensorDaoInstance ??= _$SensorDao(database, changeListener);
  }
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _usuarioInsertionAdapter = InsertionAdapter(
            database,
            'usuarios',
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuario> _usuarioInsertionAdapter;

  @override
  Future<Usuario?> findByNombre(String nombre) async {
    return _queryAdapter.query('SELECT * FROM usuarios WHERE nombre = ?1',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            password: row['password'] as String),
        arguments: [nombre]);
  }

  @override
  Future<List<Usuario>> findAllUsuarios() async {
    return _queryAdapter.queryList('SELECT * FROM usuarios',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            password: row['password'] as String));
  }

  @override
  Future<void> insertUsuario(Usuario usuario) async {
    await _usuarioInsertionAdapter.insert(usuario, OnConflictStrategy.abort);
  }
}

class _$SensorDao extends SensorDao {
  _$SensorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sensorInsertionAdapter = InsertionAdapter(
            database,
            'sensores',
            (Sensor item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'tipo': item.tipo,
                  'modelo': item.modelo,
                  'descripcion': item.descripcion,
                  'datasheet_url': item.datasheetUrl,
                  'imagen_url': item.imagenUrl,
                  'usuario_id': item.usuarioId
                }),
        _sensorUpdateAdapter = UpdateAdapter(
            database,
            'sensores',
            ['id'],
            (Sensor item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'tipo': item.tipo,
                  'modelo': item.modelo,
                  'descripcion': item.descripcion,
                  'datasheet_url': item.datasheetUrl,
                  'imagen_url': item.imagenUrl,
                  'usuario_id': item.usuarioId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sensor> _sensorInsertionAdapter;

  final UpdateAdapter<Sensor> _sensorUpdateAdapter;

  @override
  Future<List<Sensor>> findByTipo(String tipo) async {
    return _queryAdapter.queryList('SELECT * FROM sensores WHERE tipo = ?1',
        mapper: (Map<String, Object?> row) => Sensor(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            tipo: row['tipo'] as String,
            modelo: row['modelo'] as String,
            descripcion: row['descripcion'] as String,
            datasheetUrl: row['datasheet_url'] as String,
            usuarioId: row['usuario_id'] as int,
            imagenUrl: row['imagen_url'] as String?),
        arguments: [tipo]);
  }

  @override
  Future<void> insertSensor(Sensor sensor) async {
    await _sensorInsertionAdapter.insert(sensor, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSensor(Sensor sensor) async {
    await _sensorUpdateAdapter.update(sensor, OnConflictStrategy.abort);
  }
}
