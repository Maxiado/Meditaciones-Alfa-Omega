import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mood.dart';
import '../providers/mood_provider.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos la nube para saber si hay un ánimo seleccionado
    final currentMood = ref.watch(moodProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Iteramos sobre todos los valores del enum (Mood.values)
      children: Mood.values.map((mood) {
        final isSelected = currentMood == mood;

        return GestureDetector(
          // Al tocar, le decimos al cerebro que guarde este estado
          onTap: () => ref.read(moodProvider.notifier).setMood(mood),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? mood.color.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? mood.color : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  mood.icon,
                  color: isSelected ? mood.color : Colors.grey,
                  size: 32,
                ),
                const SizedBox(height: 5),
                Text(
                  mood.displayName,
                  style: TextStyle(
                    color: isSelected ? mood.color : Colors.grey,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
