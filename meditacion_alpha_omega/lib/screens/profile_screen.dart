import 'package:flutter/material.dart';
import '../models/meditation_session.dart';

class ProfileScreen extends StatelessWidget {
  final List<MeditationSession> history;
  const ProfileScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Hiciste ${history.length} sesiones de meditación",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
