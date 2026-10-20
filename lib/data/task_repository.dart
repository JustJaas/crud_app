import 'package:crud_app/data/local_storage.dart';
import 'package:crud_app/domain/task.dart';
import 'package:hive/hive.dart';

class TaskRepository {
  Box<Task> get _box => Hive.box<Task>(LocalStorage.tasksBoxName);

  List<Task> getAll() {
    final List<Task> tasks = _box.values.toList();
    tasks.sort((Task a, Task b) => b.createdAt.compareTo(a.createdAt));
    return tasks;
  }

  Future<void> save(Task task) {
    return _box.put(task.id, task);
  }

  Future<void> delete(String id) {
    return _box.delete(id);
  }
}
