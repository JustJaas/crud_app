import 'package:crud_app/domain/task.dart';
import 'package:crud_app/presentation/providers/task_providers.dart';
import 'package:crud_app/presentation/screens/task_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final String taskId;

  Task? _findTask(List<Task> tasks) {
    for (final Task candidate in tasks) {
      if (candidate.id == taskId) {
        return candidate;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> tasks = ref.watch(TaskProviders.taskList);
    final Task? task = _findTask(tasks);

    if (task == null) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de tarea'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Editar',
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      TaskFormScreen(existingTask: task),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Eliminar',
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context);
              ref.read(TaskProviders.taskList.notifier).deleteTask(task.id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              task.title,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted
                      ? colorScheme.primary
                      : colorScheme.outline,
                ),
                const SizedBox(width: 8),
                Text(task.isCompleted ? 'Completada' : 'Pendiente'),
              ],
            ),
            const SizedBox(height: 20),
            if (task.description.isNotEmpty) ...<Widget>[
              Text(
                'Descripción',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(task.description),
              const SizedBox(height: 20),
            ],
            Text(
              'Creada el ${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
