import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mood.dart';

class MoodNotifier extends Notifier<Mood?> {
  @override
  Mood? build() {
    return null; // Inicialmente no hay ningún estado seleccionado
  }

  void setMood(Mood selectedMood) {
    state = selectedMood; // Actualizamos el estado
  }
}

// Nuestro proveedor global
final moodProvider = NotifierProvider<MoodNotifier, Mood?>(() {
  return MoodNotifier();
});
