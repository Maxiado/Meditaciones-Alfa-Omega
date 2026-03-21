import 'package:flutter/material.dart';
import '../models/meditation_session.dart';
import 'timer_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Aquí vive la verdad absoluta de nuestra app
  final List<MeditationSession> _history = [];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // REGLA DE ORO DE FLUTTER: Los datos fluyen hacia abajo (pasando _history a ProfileScreen).
    // Los eventos fluyen hacia arriba (TimerScreen llama a la función onSessionCompleted).
    final List<Widget> screens = [
      TimerScreen(
        // Le pasamos la función que el TimerScreen ejecutará al llegar a cero
        onSessionCompleted: (MeditationSession newSession) {
          setState(() {
            // Agregamos la nueva sesión a la lista general
            _history.add(newSession);
          });
        },
      ),
      ProfileScreen(history: _history),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Meditation'),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Meditate',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
