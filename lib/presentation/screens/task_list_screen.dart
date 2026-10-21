import 'package:crud_app/domain/task.dart';
import 'package:crud_app/presentation/providers/task_provider.dart';
import 'package:crud_app/presentation/screens/task_detail_screen.dart';
import 'package:crud_app/presentation/screens/task_form_screen.dart';
import 'package:crud_app/presentation/widgets/empty_state.dart';
import 'package:crud_app/presentation/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> tasks = ref.watch(taskListProvider);
    final TaskListNotifier notifier = ref.read(taskListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de Tareas')),
      body: tasks.isEmpty
          ? const EmptyState()
          : ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                final Task task = tasks[index];
                return TaskItem(
                  task: task,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            TaskDetailScreen(taskId: task.id),
                      ),
                    );
                  },
                  onToggleCompleted: () => notifier.toggleCompleted(task),
                  onDelete: () => notifier.deleteTask(task.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const TaskFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
