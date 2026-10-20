import 'package:crud_app/data/task_repository.dart';
import 'package:crud_app/domain/task.dart';
import 'package:crud_app/presentation/providers/task_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskProviders {
  static final Provider<TaskRepository> repository = Provider<TaskRepository>(
    (Ref ref) => TaskRepository(),
  );

  static final NotifierProvider<TaskListNotifier, List<Task>> taskList =
      NotifierProvider<TaskListNotifier, List<Task>>(TaskListNotifier.new);
}
