import 'package:flutter/material.dart';

// 1. El Enum básico
enum Mood { happy, calm, focused, anxious, tired }

// 2. La Extensión: Le damos métodos y propiedades a nuestro Enum
extension MoodExtension on Mood {
  String get displayName {
    switch (this) {
      case Mood.happy:
        return 'Happy';
      case Mood.calm:
        return 'Calm';
      case Mood.focused:
        return 'Focused';
      case Mood.anxious:
        return 'Anxious';
      case Mood.tired:
        return 'Tired';
    }
  }

  IconData get icon {
    switch (this) {
      case Mood.happy:
        return Icons.sentiment_very_satisfied;
      case Mood.calm:
        return Icons.sentiment_satisfied;
      case Mood.focused:
        return Icons.psychology;
      case Mood.anxious:
        return Icons.sentiment_dissatisfied;
      case Mood.tired:
        return Icons.bedtime;
    }
  }

  Color get color {
    switch (this) {
      case Mood.happy:
        return Colors.orange;
      case Mood.calm:
        return Colors.teal;
      case Mood.focused:
        return Colors.blue;
      case Mood.anxious:
        return Colors.redAccent;
      case Mood.tired:
        return Colors.deepPurple;
    }
  }
}
