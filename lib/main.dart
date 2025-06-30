import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensoresapp/config/database/database.dart';
import 'package:sensoresapp/core/router/app_router.dart';
import 'package:sensoresapp/data/entities/user_entity.dart';
import 'package:sensoresapp/theme/theme_provider.dart';

late final AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar la base de datos
  database = await $FloorAppDatabase.databaseBuilder('app_sensores_v2.db').build();

  // Agregar usuarios de prueba si no existen
  await _addTestUsers();

  // Iniciar la app con MultiProvider
  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Funcion para agregar usuarios de prueba
Future<void> _addTestUsers() async {
  final usuarios = await database.usuarioDao.findAllUsuarios();

  if (usuarios.isEmpty) {
    await database.usuarioDao.insertUsuario(Usuario(nombre: 'admin', password: '1234'));
    await database.usuarioDao.insertUsuario(Usuario(nombre: 'juan', password: 'abcd'));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          builder: (context, child) {
            final scale = themeProvider.fontScale;
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!,
            );
          },
        );
      },
    );
  }
}
