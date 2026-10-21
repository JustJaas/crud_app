import 'package:crud_app/domain/task.dart';
import 'package:crud_app/presentation/utils/task_form_utils.dart';
import 'package:crud_app/presentation/providers/task_list_notifier.dart';
import 'package:crud_app/presentation/providers/task_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key, this.existingTask});

  final Task? existingTask;

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  bool get _isEditing => widget.existingTask != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingTask?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingTask?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final TaskListNotifier notifier = ref.read(TaskProviders.taskList.notifier);
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();
    final Task? existing = widget.existingTask;

    if (existing == null) {
      notifier.addTask(title: title, description: description);
    } else {
      notifier.updateTask(
        existing.copyWith(title: title, description: description),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Editar tarea' : 'Nueva tarea')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
                validator: TaskFormUtils.validateTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submit,
                child: Text(_isEditing ? 'Guardar cambios' : 'Crear tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
