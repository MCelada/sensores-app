import 'package:clase2/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final List<Map<String, String>> usuarios = [
  {"user": "admin", "password": "admin"},
  {"user": "admin2", "password": "admin"},
  {"user": "admin3", "password": "admin"},
];



class LoginScreen extends StatelessWidget {
  static const String name = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  _LoginView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              hintText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            validarLogin(_usernameController.text, _passwordController.text, context);            //context.goNamed(HomeScreen.name);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}


void validarLogin(String user, String password, BuildContext context) {
  bool usuarioValido = usuarios.any((usuario) =>
      usuario["user"] == user && usuario["password"] == password);

  if (usuarioValido) {
    // Redirigir al Home
    context.pushNamed(HomeScreen.name, extra: user);
  } else {
    // Mostrar un mensaje de error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario o contraseña incorrectos')),
    );
  }
}
