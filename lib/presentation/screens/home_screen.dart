import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sensoresapp/core/menu/menu_item.dart';
import 'package:sensoresapp/presentation/screens/temperature_screen.dart';


class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensores'),
    ),
    drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Encabezado del Drawer
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text('$userName@example.com'),
              currentAccountPicture: CircleAvatar(
                child: Text(userName[0].toUpperCase()),
              ),
            ),
            // Opciones del menú
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed('profile', extra: userName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {
                context.push('/settings-screen');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                context.go('/loginScreen');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
       onPressed: () {      
      context.push('/newsensor-screen');
    },
    child: const Icon(Icons.add),
    tooltip: 'Agregar',
  ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const items = menuItems;

    return ListView.builder(
      itemCount:items.length,
      itemBuilder: (context, index){
        return _ItemMenuView(item: menuItems[index]);
        });
  }
}

class _ItemMenuView extends StatelessWidget {

  final item;
  const _ItemMenuView({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      leading: Icon(item.icon),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        context.push(item.link);
      },
    );
  }
}