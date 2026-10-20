import 'package:crud_app/domain/task.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleCompleted,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggleCompleted;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Dismissible(
      key: ValueKey<String>(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) => onDelete(),
      background: Container(
        color: colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) => onToggleCompleted(),
        ),
        title: Text(
          task.title,
          style: task.isCompleted
              ? textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: colorScheme.outline,
                )
              : null,
        ),
        subtitle: task.description.isEmpty
            ? null
            : Text(
                task.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
