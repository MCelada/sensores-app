import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _displayText = TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter a search term',
    ),
  ).toString(); // Variable para almacenar el texto a mostrar
  double _fontSize = 30; // Variable para controlar el tamaño de la fuente
  Color _fontColor = Colors.blue; // Variable para controlar el color de la fuente
  bool _isTextVisible = true;


  void _updateText(String newText) {
    setState(() {
      _displayText = newText;
    });
  }

  void increaseFontSize() {
    setState(() {
      _fontSize += 5; // Incrementa el tamaño de la fuente
    });
  }

  void decreaseFontSize() {
    setState(() {
      if (_fontSize > 10) _fontSize -= 5; // Disminuye el tamaño de la fuente, con un límite mínimo
    });
  }

  void changeFontColorRed() {
    setState(() {
      _fontColor = Colors.red; // Cambia el color de la fuente
    });
  }
  void changeFontColorBlue() {
    setState(() {
      _fontColor = Colors.blue; // Cambia el color de la fuente
    });
  }

  void toggleTextVisibility() {
    setState(() {
      _isTextVisible = !_isTextVisible;
    });
  }

  @override
 Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isTextVisible)
              Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: _fontSize, // Tamaño de la fuente
                      fontWeight: FontWeight.bold,
                      color: _fontColor, // Color de la fuente
                    ),
                  ),
                  const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: increaseFontSize,//() => _updateText('Button 1 Clicked'),
                      child: Text('Incrementar fuente'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: changeFontColorBlue,//=> _updateText('Button 2 Clicked'),
                      child: Text('Cambiar color a azul'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: toggleTextVisibility,//() => _updateText('Button 3 Clicked'),
                      child: Text('Mostrar texto'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: decreaseFontSize,//=> _updateText('Button 2 Clicked'),
                      child: Text('Decrementar Fuente'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: changeFontColorRed,//=> _updateText('Button 2 Clicked'),
                      child: Text('Cambiar color a rojo'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: toggleTextVisibility,//() => _updateText('Button 6 Clicked'),
                    child: Text('Ocultar texto'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}