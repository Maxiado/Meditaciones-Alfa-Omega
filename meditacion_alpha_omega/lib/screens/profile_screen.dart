import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/history_provider.dart';
import '../models/mood.dart'; // <-- ¡ESTE ES EL IMPORT MÁGICO QUE FALTABA!

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    if (history.isEmpty) {
      return const Center(
        child: Text(
          "No sessions yet. Go meditate!",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final session = history[index];
        final String minuteStr = session.dateTime.minute.toString().padLeft(
          2,
          '0',
        );

        // Arreglamos el warning de interpolación (sin usar el símbolo + )
        final extraText = session.mood != null
            ? " • Feeling ${session.mood!.displayName}"
            : "";

        return ListTile(
          leading: Icon(
            session.mood?.icon ?? Icons.check_circle,
            color: session.mood?.color ?? Colors.teal,
            size: 40,
          ),
          title: Text(
            "${session.durationMinutes} Minutes",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Usamos interpolación directa
          subtitle: Text(
            "${session.dateTime.day}/${session.dateTime.month}/${session.dateTime.year} at ${session.dateTime.hour}:$minuteStr$extraText",
          ),
        );
      },
    );
  }
}
