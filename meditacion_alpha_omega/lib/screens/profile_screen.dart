import 'package:flutter/material.dart';
import '../models/meditation_session.dart';

class ProfileScreen extends StatelessWidget {
  final List<MeditationSession> history;

  const ProfileScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    // Si la lista está vacía, mostramos un mensaje de aliento
    if (history.isEmpty) {
      return const Center(
        child: Text(
          "No sessions yet. Go meditate!",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    // Si hay sesiones, construimos una lista
    return ListView.builder(
      itemCount: history.length, // ¿Cuántas veces se repite el ciclo?
      itemBuilder: (context, index) {
        // Obtenemos la sesión específica de esta vuelta del ciclo
        final session = history[index];

        // Formateamos la hora para que los minutos menores a 10 tengan un '0' adelante (ej. 14:05)
        final String minuteStr = session.dateTime.minute.toString().padLeft(
          2,
          '0',
        );

        // ListTile es un widget nativo excelente para listas ordenadas
        return ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.teal, size: 40),
          title: Text(
            "${session.durationMinutes} Minutes",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${session.dateTime.day}/${session.dateTime.month}/${session.dateTime.year} at ${session.dateTime.hour}:$minuteStr",
          ),
        );
      },
    );
  }
}
