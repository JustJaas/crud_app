import 'package:crud_app/data/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<TaskRepository> taskRepositoryProvider =
    Provider<TaskRepository>((Ref ref) => TaskRepository());
