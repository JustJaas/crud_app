import 'package:crud_app/data/task_repository.dart';
import 'package:crud_app/domain/task.dart';
import 'package:crud_app/presentation/providers/task_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<TaskListNotifier, List<Task>> taskListProvider =
    NotifierProvider<TaskListNotifier, List<Task>>(TaskListNotifier.new);

class TaskListNotifier extends Notifier<List<Task>> {
  TaskRepository get _repository => ref.read(taskRepositoryProvider);

  @override
  List<Task> build() {
    return _repository.getAll();
  }

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    final Task task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _repository.save(task);
    state = _repository.getAll();
  }

  Future<void> updateTask(Task task) async {
    await _repository.save(task);
    state = _repository.getAll();
  }

  Future<void> toggleCompleted(Task task) {
    return updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }

  Future<void> deleteTask(String id) async {
    await _repository.delete(id);
    state = _repository.getAll();
  }
}
