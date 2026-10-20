class Task {
  const Task({
    required this.id,
    required this.title,
    required this.createdAt,
    this.description = '',
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }
}
