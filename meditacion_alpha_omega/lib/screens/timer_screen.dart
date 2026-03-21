import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/timer_provider.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. ESCUCHAR (Read Only): Obtenemos los datos actuales (selectedMinutes, etc)
    final timerState = ref.watch(timerProvider);

    // 2. ACCIONAR (Write Only): Obtenemos los métodos (start, stop, etc)
    final timerController = ref.read(timerProvider.notifier);

    // Damos formato al texto localmente (pura estética visual)
    final minutesStr = (timerState.remainingSeconds ~/ 60).toString().padLeft(
      2,
      '0',
    );
    final secondsStr = (timerState.remainingSeconds % 60).toString().padLeft(
      2,
      '0',
    );
    final formattedTime = '$minutesStr:$secondsStr';

    return Scaffold(
      appBar: AppBar(title: const Text("Custom Meditation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Deep Breath", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),

            Text(
              formattedTime,
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Slider(
                value: timerState.selectedMinutes.toDouble(),
                min: 1,
                max: 60,
                divisions: 59,
                label: "${timerState.selectedMinutes} min",
                // Si corre, se anula. Si no, le avisa al controlador.
                onChanged: timerState.isRunning
                    ? null
                    : (value) => timerController.updateMinutes(value),
              ),
            ),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // Decidimos qué función del controlador llamar
                  onPressed: timerState.isRunning
                      ? timerController.stop
                      : timerController.start,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: Text(timerState.isRunning ? "Pause" : "Start"),
                ),

                const SizedBox(width: 20),

                OutlinedButton(
                  onPressed:
                      (timerState.isRunning ||
                          timerState.remainingSeconds !=
                              timerState.selectedMinutes * 60)
                      ? timerController.reset
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
      ),
    );
  }
}
