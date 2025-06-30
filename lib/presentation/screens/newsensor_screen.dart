import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensoresapp/config/database/database.dart';
import 'package:sensoresapp/data/entities/sensor_entity.dart';

class AddSensorScreen extends StatefulWidget {
  static const String name = 'add-sensor';

  const AddSensorScreen({super.key});

  @override
  State<AddSensorScreen> createState() => _AddSensorScreenState();
}

class _AddSensorScreenState extends State<AddSensorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _datasheetUrlController = TextEditingController();
  final TextEditingController _imagenUrlController = TextEditingController();

  final List<String> _tiposSensor = [
    'temperatura',
    'humedad',
    'movimiento',
    'distancia',
    'presion',
    'luz',
  ];

  String? _tipoSeleccionado = 'temperatura';

  bool _guardando = false;


  Future<void> _guardarSensor() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

  final sensor = Sensor(
    id: null,
    nombre: _nombreController.text.trim(),
    modelo: _modeloController.text.trim(),
    descripcion: _descripcionController.text.trim(),
    datasheetUrl: _datasheetUrlController.text.trim(), 
    imagenUrl: _imagenUrlController.text.trim(),
    tipo: _tipoSeleccionado!,
    usuarioId: 1, 
  );


    final db = context.read<AppDatabase>();
    await db.sensorDao.insertSensor(sensor);

    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sensor guardado')),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _modeloController.dispose();
    _descripcionController.dispose();
    _datasheetUrlController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Sensor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese el nombre' : null,
              ),
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese el modelo' : null,
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _datasheetUrlController,
                decoration: const InputDecoration(labelText: 'URL del datasheet'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese la URL' : null,
              ),
              TextFormField(
                controller: _imagenUrlController,
                decoration: const InputDecoration(labelText: 'URL de la imagen'),
              ),
              DropdownButtonFormField<String>(
                value: _tipoSeleccionado,
                decoration: const InputDecoration(labelText: 'Tipo de sensor'),
                items: _tiposSensor.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo[0].toUpperCase() + tipo.substring(1)), // Capitaliza la primera letra
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _tipoSeleccionado = value;
                  });
                },
                validator: (value) => value == null ? 'Seleccione el tipo' : null,
              ),

              const SizedBox(height: 24),
              _guardando
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                      onPressed: _guardarSensor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
