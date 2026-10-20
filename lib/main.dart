import 'package:crud_app/data/local_storage.dart';
import 'package:crud_app/presentation/screens/task_list_screen.dart';
import 'package:crud_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const ProviderScope(child: TaskManagerApp()));
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas Personales',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const TaskListScreen(),
    );
  }
}
