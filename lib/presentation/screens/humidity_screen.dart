import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sensoresapp/config/database/database.dart';
import 'package:sensoresapp/data/entities/sensor_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class HumiditySensorsScreen extends StatefulWidget {
  static const String name = 'humidity-sensors';

  const HumiditySensorsScreen({super.key});

  @override
  State<HumiditySensorsScreen> createState() => _HumiditySensorsScreenState();
}

class _HumiditySensorsScreenState extends State<HumiditySensorsScreen> {
  late Future<List<Sensor>> _sensorsFuture;

  @override
  void initState() {
    super.initState();
    final db = Provider.of<AppDatabase>(context, listen: false);
    _sensorsFuture = db.sensorDao.findByTipo('humedad');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensores de Humedad')),
      body: FutureBuilder<List<Sensor>>(
        future: _sensorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final sensors = snapshot.data ?? [];

          if (sensors.isEmpty) {
            return const Center(child: Text('No hay sensores de humedad.'));
          }

          return ListView.builder(
            itemCount: sensors.length,
            itemBuilder: (context, index) {
              final sensor = sensors[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: sensor.imagenUrl != null
                      ? Image.network(sensor.imagenUrl!, width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.device_thermostat, size: 40),
                  title: Text(sensor.nombre),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Modelo: ${sensor.modelo}'),
                      Text(sensor.descripcion),
                      GestureDetector(
                        onTap: () {
                          final url = Uri.parse(sensor.datasheetUrl);
                          launchUrl(url);
                        },
                        child: Text(
                          'Ver datasheet',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'editar') {
                        context.pushNamed(
                          'edit-sensor',
                          extra: sensor,
                        );
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem<String>(
                        value: 'editar',
                        child: Text('Editar'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}