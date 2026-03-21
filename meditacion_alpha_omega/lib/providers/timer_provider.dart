import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meditation_session.dart';
import 'history_provider.dart';
import 'mood_provider.dart'; // Importante para leer el estado de ánimo

// 1. LA CLASE DE ESTADO (Los datos puros e inmutables)
class TimerState {
  final int selectedMinutes;
  final int remainingSeconds;
  final bool isRunning;

  TimerState({
    required this.selectedMinutes,
    required this.remainingSeconds,
    required this.isRunning,
  });

  // El patrón 'copyWith' para mantener la inmutabilidad
  TimerState copyWith({
    int? selectedMinutes,
    int? remainingSeconds,
    bool? isRunning,
  }) {
    return TimerState(
      selectedMinutes: selectedMinutes ?? this.selectedMinutes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

// 2. EL CONTROLADOR LÓGICO (El Cerebro)
class TimerNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    // Estado inicial de la app al abrir la pantalla
    return TimerState(
      selectedMinutes: 15,
      remainingSeconds: 15 * 60,
      isRunning: false,
    );
  }

  void updateMinutes(double value) {
    final minutes = value.toInt();
    state = state.copyWith(
      selectedMinutes: minutes,
      remainingSeconds: minutes * 60,
    );
  }

  void start() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        stop();
        _saveSession(); // Llamamos al método interno al llegar a 0
        reset();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void reset() {
    stop();
    state = state.copyWith(remainingSeconds: state.selectedMinutes * 60);
  }

  // MÉTODO INTERNO (Oculto a la vista, se comunica con los otros providers)
  void _saveSession() {
    // 1. Leemos el estado de ánimo actual desde la otra nube
    final currentMood = ref.read(moodProvider);

    // 2. Creamos la sesión incluyendo el estado de ánimo
    final newSession = MeditationSession(
      state.selectedMinutes,
      DateTime.now(),
      mood: currentMood,
    );

    // 3. Lo enviamos a la nube del historial
    ref.read(historyProvider.notifier).addSession(newSession);
  }
}

// 3. EL PROVEEDOR GLOBAL
final timerProvider = NotifierProvider<TimerNotifier, TimerState>(() {
  return TimerNotifier();
});
