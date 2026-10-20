import 'package:crud_app/domain/task.dart';
import 'package:hive/hive.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final String id = reader.readString();
    final String title = reader.readString();
    final String description = reader.readString();
    final bool isCompleted = reader.readBool();
    final DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(
      reader.readInt(),
    );

    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeBool(obj.isCompleted);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
