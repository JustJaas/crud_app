import 'package:crud_app/data/task_adapter.dart';
import 'package:crud_app/domain/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String tasksBoxName = 'tasks_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>(tasksBoxName);
  }
}
