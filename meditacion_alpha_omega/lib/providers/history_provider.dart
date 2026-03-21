import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meditation_session.dart';

// 1. LA LÓGICA (Notifier en Riverpod 3.0)
class HistoryNotifier extends Notifier<List<MeditationSession>> {
  // En la sintaxis moderna, el estado inicial no se pasa con 'super()',
  // sino que se devuelve dentro de este método obligatorio llamado 'build()'.
  @override
  List<MeditationSession> build() {
    return []; // Nuestro estado inicial es una lista vacía
  }

  // Método para agregar una sesión
  void addSession(MeditationSession session) {
    // La regla de inmutabilidad sigue intacta: creamos una copia y agregamos el nuevo elemento.
    state = [...state, session];
  }
}

// 2. EL PROVEEDOR (NotifierProvider)
// Ahora usamos NotifierProvider en lugar de StateNotifierProvider
final historyProvider =
    NotifierProvider<HistoryNotifier, List<MeditationSession>>(() {
      return HistoryNotifier();
    });
