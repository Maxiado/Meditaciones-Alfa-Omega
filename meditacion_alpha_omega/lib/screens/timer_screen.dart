import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int minutes = 15;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Respira Profundo", style: TextStyle(fontSize: 24)),
          Text(minutes.toString(), style: const TextStyle(fontSize: 48)),
          ElevatedButton(
            onPressed: () {
              print("Boton Start presionado");
            },
            child: const Text("Start"),
          ),
        ],
      ),
    );
  }
}
