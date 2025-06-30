import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String link;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.link,
  });
}

const List<MenuItem> menuItems=[
  MenuItem(
    title: 'Sensores de Temperatura',
    subtitle: 'Diferentes Sensores de Temperatura', 
    icon: Icons.thermostat, 
    link: '/temperature-sensors',
    ),
  MenuItem(
    title: 'Sensores de Humedad', 
    subtitle: 'Diferentes Sensores de Humedad', 
    icon: Icons.water_drop, 
    link: '/humidity-sensors',
    ),
  MenuItem(
    title: 'Sensores de movimiento', 
    subtitle: 'Diferentes Sensores de Movimiento', 
    icon: Icons.directions_run, 
    link: '/motion-sensors',
    ),
    MenuItem(
    title: 'Sensores de distancia', 
    subtitle: 'Diferentes Sensores de Distancia', 
    icon: Icons.straighten, 
    link: '/distance-sensors',
    ),
  MenuItem(
    title: 'Sensores de presión', 
    subtitle: 'Diferentes Sensores de Presión', 
    icon: Icons.compress, 
    link: '/pressure-sensors',
    ),
  MenuItem(
    title: 'Sensores de luz', 
    subtitle: 'Diferentes Sensores de Luz', 
    icon: Icons.wb_sunny, 
    link: '/light-sensors',
    ),
];