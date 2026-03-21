import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const int _initialMinutes = 15;
  int _remainingSeconds = _initialMinutes * 60;
  Timer? _timer;
  bool _isRunning = false;

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _stopTimer();
          print("Meditación Finalizada!");
        }
      });
    });
  }

  void _stopTimer() {
    // Cancelamos la ejecución del objeto Timer
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  // --- INTERFAZ VISUAL ---
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Meditación", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20), // Un espacio vacío para separar elementos
          // Usamos nuestro método Getter para mostrar el texto formateado
          Text(
            _formattedTime,
            style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 40),

          // Botón que cambia su comportamiento dependiendo si está corriendo o no
          ElevatedButton(
            // Operador ternario: Si corre, la función es stop. Si no, es start.
            onPressed: _isRunning ? _stopTimer : _startTimer,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(fontSize: 20),
            ),
            // El texto del botón también cambia
            child: Text(_isRunning ? "Pausar" : "Comenzar"),
          ),
        ],
      ),
    );
  }
}
