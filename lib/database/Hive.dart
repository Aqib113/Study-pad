import 'package:notesapp/database/models.dart';
import 'package:hive/hive.dart';

class TaskManager {
  static Future<void> saveTask(String title) async {
    final taskToBeAdded = Task(title: title);

    final taskBox = Hive.box<Task>('Taskbox');

    await taskBox.add(taskToBeAdded);
  }

  static Future<Iterable<Task>> getAllTasks() async {
    final taskBox = Hive.box<Task>('TaskBox');
    final tasks = taskBox.values;
    return tasks;
  }

  static Future changeStatus(key, value) async {
    final taskBox = Hive.box<Task>('TaskBox');
    final task = await taskBox.get(key);
    if (task != null) {
      task.status = value ? TaskStatus.completed : TaskStatus.pending;
      task.save();
    }
  }

  static Future deleteTask(key) async {
    final taskBox = Hive.box<Task>('TaskBox');
    taskBox.delete(key);
  }
}
