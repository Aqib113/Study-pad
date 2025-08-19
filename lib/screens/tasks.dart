import 'package:flutter/material.dart';
import 'package:notesapp/database/Hive.dart';
import 'package:notesapp/custom_widgets/TasksShowCase.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/custom_widgets/CustomSearchBar.dart';
import 'package:notesapp/database/models.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPage();
}

class _TaskPage extends State<TaskPage> {
  TextEditingController SearchBar_controller = TextEditingController();
  TextEditingController Task_controller = TextEditingController();
  List<Task> tasks = [];

  _TaskPage() {
    getAllTasks();
  }

  Future<void> saveNewTask() async {
    await TaskManager.saveTask(Task_controller.text.toString());
    Navigator.pop(context);
    await getAllTasks();
  }

  Future<void> getAllTasks() async {
    tasks = (await TaskManager.getAllTasks()).toList();
    setState(() {});
  }

  Future<void> deleteTasks(key) async {
    await TaskManager.deleteTask(key);
    getAllTasks();
  }

  Future<void> ChangeStatus(key, value) async {
    print(value);
    await TaskManager.changeStatus(key, value);
    setState(() {
      
    });
  }

  void AddNewTask() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.primaryColor,
        titlePadding: EdgeInsets.all(15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New Task",
              style: TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(
                Icons.close_rounded,
                color: const Color.fromARGB(255, 236, 35, 35),
                size: 24,
              ),
            ),
          ],
        ),
        content: TextField(
          controller: Task_controller,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),

        actions: [
          TextButton(
            onPressed: saveNewTask,
            child: Text(
              "Save",
              style: TextStyle(color: AppColors.headingColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomSearchBar(Req_controller: SearchBar_controller),

            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  tasks.length,
                  (index) => TaskShowcase(
                    task: tasks[index].title,
                    taskStatus: tasks[index].status,
                    onChange: (bool? value) {
                      ChangeStatus(tasks[index].key, value);
                    },
                    deleteTask: () {
                      deleteTasks(tasks[index].key);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: AddNewTask,
        elevation: 0,
        backgroundColor: AppColors.thirdColor,
        foregroundColor: AppColors.stylishText,
        child: Icon(Icons.add, color: AppColors.stylishText, size: 32),
      ),
    );
  }
}
