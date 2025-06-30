import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sensoresapp/presentation/screens/home_screen.dart';
import 'package:sensoresapp/config/database/database.dart';
import 'package:sensoresapp/data/entities/user_entity.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de imagen
          SizedBox.expand(
            child: Image.asset(
              'assets/images/fondo_login.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Capa semitransparente opcional
          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          // Contenido del login
          const Center(
            child: _LoginView(),
          ),
        ],
      ),
    );
  }
}


class _LoginView extends StatefulWidget {
  const _LoginView({super.key});

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

 late final AppDatabase db;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

Future<void> _initDb() async {
  db = await $FloorAppDatabase.databaseBuilder('app_sensores.db').build();
}


Future<void> _login(BuildContext context) async {
  final username = _usernameController.text.trim();
  final password = _passwordController.text;

  final usuario = await db.usuarioDao.findByNombre(username);

  if (usuario != null && usuario.password == password) {
    context.goNamed(HomeScreen.name, extra: usuario.nombre);
  } else {
    setState(() {
      _errorMessage = 'Usuario o contraseña incorrectos';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 275),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              hintText: 'Usuario',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              filled: true,               // Habilita el fondo
              fillColor: Colors.white,    // Color del fondo
            ),
              style: const TextStyle(
                fontWeight: FontWeight.w500, 
                fontSize: 16, 
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Contraseña',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              filled: true,               // Habilita el fondo
              fillColor: Colors.white,    // Color del fondo
            ),
            style: const TextStyle(
                fontWeight: FontWeight.w500, // Hace la letra más gruesa
                fontSize: 16, // Opcional, para ajustar el tamaño
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _login(context),
            child: const Text('Ingresar'),
          ),
        ],
      ),
    );
  }
}
