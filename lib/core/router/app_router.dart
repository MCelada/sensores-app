import 'package:go_router/go_router.dart';
import 'package:sensoresapp/presentation/screens/home_screen.dart';
import 'package:sensoresapp/presentation/screens/login.dart';
import 'package:sensoresapp/presentation/screens/temperature_screen.dart';
import 'package:sensoresapp/presentation/screens/humidity_screen.dart';
import 'package:sensoresapp/presentation/screens/motion_screen.dart';
import 'package:sensoresapp/presentation/screens/distance_screen.dart';
import 'package:sensoresapp/presentation/screens/pressure_screen.dart';
import 'package:sensoresapp/presentation/screens/light_screen.dart';
import 'package:sensoresapp/presentation/screens/profile_screen.dart';
import 'package:sensoresapp/presentation/screens/settings_screen.dart';
import 'package:sensoresapp/presentation/screens/newsensor_screen.dart';
import 'package:sensoresapp/presentation/screens/edit-sensor.dart';
import 'package:sensoresapp/data/entities/sensor_entity.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/loginScreen',
  routes: [
    GoRoute(
      path: '/loginScreen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/homeScreen',
    builder: (context, state) => HomeScreen(userName: state.extra as String),
        ),
     GoRoute(
      path: '/temperature-sensors',
      builder: (cnotext, state) => const TemperatureSensorsScreen(),
    ),
    GoRoute(
      path: '/humidity-sensors',
      builder: (cnotext, state) => const HumiditySensorsScreen(),
    ),
    GoRoute(
      path: '/motion-sensors',
      builder: (cnotext, state) => const MotionSensorsScreen(),
    ),
    GoRoute(
      path: '/distance-sensors',
      builder: (cnotext, state) => const DistanceSensorsScreen(),
    ),
    GoRoute(
      path: '/pressure-sensors',
      builder: (cnotext, state) => const PressureSensorsScreen(),
    ),
    GoRoute(
      path: '/light-sensors',
      builder: (cnotext, state) => const LightSensorsScreen(),
    ),
    GoRoute(
      path: '/profile-screen',
      name: ProfileScreen.name,
      builder: (context, state) {
        final userName = state.extra as String;
        return ProfileScreen(userName: userName);
      },
    ),
    GoRoute(
      path: '/settings-screen',
      name: SettingsScreen.name,
      builder: (context, state) => const SettingsScreen(),
    ),
     GoRoute(
      path: '/newsensor-screen',
      name: AddSensorScreen.name,
      builder: (context, state) => const AddSensorScreen(),
    ),
      GoRoute(
      path: '/edit-sensor',
      name: 'edit-sensor',
      builder: (context, state) {
        final sensor = state.extra as Sensor;
        return EditSensorScreen(sensor: sensor);
      },
    ),
  ],
);
