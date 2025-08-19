import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
enum TaskStatus {
  @HiveField(0)
  completed,

  @HiveField(1)
  pending,

  @HiveField(2)
  deleted,
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  TaskStatus status;

  Task({required this.title, this.status = TaskStatus.pending});
}
