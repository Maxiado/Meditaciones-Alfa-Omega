import 'mood.dart'; // Importamos el enum

class MeditationSession {
  final int durationMinutes;
  final DateTime dateTime;
  final Mood? mood; // Puede ser nulo si el usuario no seleccionó nada

  // Usamos {} para hacer que el estado de ánimo sea un parámetro opcional por nombre
  MeditationSession(this.durationMinutes, this.dateTime, {this.mood});
}
