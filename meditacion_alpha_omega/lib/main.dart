import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Meditación',
      theme: ThemeData(
        // Cambiamos a un color más "zen"
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(title: 'Mi Meditación'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ¡Aquí está la variable que creaste!
  int minutos = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // ¡Aquí está el código visual que construimos juntos!
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Respira Profundo", style: TextStyle(fontSize: 24)),
            Text(minutos.toString(), style: const TextStyle(fontSize: 48)),
            ElevatedButton(
              onPressed: () {
                // Pronto le daremos vida a este botón
                print("Botón presionado");
              },
              child: const Text("Empezar"),
            ),
          ],
        ),
      ),
    );
  }
}
