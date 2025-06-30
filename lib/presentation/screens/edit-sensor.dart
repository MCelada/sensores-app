import 'package:flutter/material.dart';
import 'package:sensoresapp/config/database/database.dart';
import 'package:sensoresapp/data/entities/sensor_entity.dart';
import 'package:provider/provider.dart';
import 'package:sensoresapp/data/sensor_dao.dart';


class EditSensorScreen extends StatefulWidget {
  final Sensor sensor;

  const EditSensorScreen({super.key, required this.sensor});

  @override
  State<EditSensorScreen> createState() => _EditSensorScreenState();
}

class _EditSensorScreenState extends State<EditSensorScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _modeloController;
  late TextEditingController _descripcionController;
  late TextEditingController _datasheetController;
  late TextEditingController _imagenController;
  late String _tipoSeleccionado;
  bool _guardando = false;

  final List<String> _tipos = [
    'temperatura',
    'humedad',
    'movimiento',
    'distancia',
    'presion',
    'luz',
  ];

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.sensor.nombre);
    _modeloController = TextEditingController(text: widget.sensor.modelo);
    _descripcionController = TextEditingController(text: widget.sensor.descripcion);
    _datasheetController = TextEditingController(text: widget.sensor.datasheetUrl);
    _imagenController = TextEditingController(text: widget.sensor.imagenUrl ?? '');
    _tipoSeleccionado = widget.sensor.tipo;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _modeloController.dispose();
    _descripcionController.dispose();
    _datasheetController.dispose();
    _imagenController.dispose();
    super.dispose();
  }

  Future<void> _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    final db = context.read<AppDatabase>();

    final sensorActualizado = Sensor(
      id: widget.sensor.id,
      nombre: _nombreController.text.trim(),
      modelo: _modeloController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      datasheetUrl: _datasheetController.text.trim(),
      imagenUrl: _imagenController.text.trim().isNotEmpty ? _imagenController.text.trim() : null,
      tipo: _tipoSeleccionado,
      usuarioId: widget.sensor.usuarioId,
    );


    await db.sensorDao.updateSensor(sensorActualizado);

    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sensor actualizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Sensor')),
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
                controller: _datasheetController,
                decoration: const InputDecoration(labelText: 'URL del datasheet'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese la URL' : null,
              ),
              TextFormField(
                controller: _imagenController,
                decoration: const InputDecoration(labelText: 'URL de la imagen'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _tipoSeleccionado,
                items: _tipos
                    .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _tipoSeleccionado = value);
                  }
                },
                decoration: const InputDecoration(labelText: 'Tipo de sensor'),
              ),
              const SizedBox(height: 24),
              _guardando
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar Cambios'),
                      onPressed: _guardarCambios,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
