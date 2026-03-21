import 'package:flutter/material.dart';
import 'dart:async';
import '../models/meditation_session.dart'; // 1. Importamos el modelo

class TimerScreen extends StatefulWidget {
  // 2. Definimos una función que recibiremos desde afuera (Callback)
  final void Function(MeditationSession) onSessionCompleted;

  const TimerScreen({super.key, required this.onSessionCompleted});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _selectedMinutes = 15;
  late int _remainingSeconds;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = _selectedMinutes * 60;
  }

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
          _resetTimer();

          // 3. ¡LA MAGIA! El temporizador llegó a 0.
          // Creamos una nueva sesión con los minutos elegidos y la hora actual.
          final newSession = MeditationSession(
            _selectedMinutes,
            DateTime.now(),
          );

          // Ejecutamos la función que nos pasó el padre a través de 'widget.'
          widget.onSessionCompleted(newSession);
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _remainingSeconds = _selectedMinutes * 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Deep Breath", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Text(
            _formattedTime,
            style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Slider(
              value: _selectedMinutes.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: "$_selectedMinutes min",
              onChanged: _isRunning
                  ? null
                  : (double value) {
                      setState(() {
                        _selectedMinutes = value.toInt();
                        _remainingSeconds = _selectedMinutes * 60;
                      });
                    },
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? _stopTimer : _startTimer,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: Text(_isRunning ? "Pause" : "Start"),
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                onPressed:
                    (_isRunning || _remainingSeconds != _selectedMinutes * 60)
                    ? _resetTimer
                    : null,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
