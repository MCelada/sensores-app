import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensoresapp/theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String name = 'settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Modo oscuro'),
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
            const SizedBox(height: 20),
            Text('Tamaño de fuente'),
            Slider(
              value: themeProvider.fontScale,
              min: 0.8,
              max: 1.5,
              divisions: 7,
              label: themeProvider.fontScale.toStringAsFixed(1),
              onChanged: (value) {
                themeProvider.setFontScale(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
      
