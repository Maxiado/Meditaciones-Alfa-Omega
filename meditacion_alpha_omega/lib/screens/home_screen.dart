import 'package:flutter/material.dart';
import 'timer_screen.dart';
import '../widgets/mood_selector.dart'; // <-- 1. Importamos el widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Frase del Día
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              children: [
                Text(
                  '"Peace comes from within. Do not seek it without."',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("- Buddha", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 2. EL NUEVO SELECTOR DE ESTADO DE ÁNIMO
          const Text(
            "How are you feeling today?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // 3. ¡Insertamos el Lego aquí!
          const MoodSelector(),

          const Spacer(),

          // 4. Botón para ir al Timer
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimerScreen()),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text("Start Custom Meditation"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
