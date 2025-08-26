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
  TextEditingController _TaskInputController = TextEditingController();
  bool _Enabled = false;
  List<Task> tasks = [];
  FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;


  void initState() {
    super.initState();
    _TaskInputController.addListener(() {
      setState(() {
        _Enabled = _TaskInputController.text.isNotEmpty;
      });

      }
    );
    getAllTasks();
  }

  Future<void> saveNewTask() async {
    await TaskManager.saveTask(_TaskInputController.text.toString());
    RemoveOverlay();
    _TaskInputController.clear();
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
    setState(() {});
  }

  void RemoveOverlay() {
    _overlayEntry?.remove();
    _TaskInputController.clear();
    _overlayEntry = null;
  }

  Widget ShowOverlay(BuildContext) {
    return Stack(
      children: [
        GestureDetector(
          onTap: RemoveOverlay,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
        ),

        Positioned(
          left: 0,
          bottom: 0,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: RemoveOverlay,
                        icon: Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 19,
                        ),
                      ),
                      Text(
                        "New Task",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.headingColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    alignment: Alignment.center,
                    child: TextField(
                      controller: _TaskInputController,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                      decoration: InputDecoration(
                        hintText: "Task To do here",
                        hintStyle: TextStyle(color: AppColors.dullWhite),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.stylishText,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.7,
                            color: AppColors.thirdColor,

                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _Enabled? saveNewTask:null,
                        child: Text("Save", style: TextStyle(color: _Enabled? AppColors.stylishText:AppColors.thirdColor),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void ShowAddNewTaskInput() async {
    _overlayEntry = OverlayEntry(builder: ShowOverlay);
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primaryColor,
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              CustomSearchBar(
                Req_controller: SearchBar_controller,
                focusNode: _focusNode,
              ),
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
          onPressed: ShowAddNewTaskInput,
          elevation: 0,
          backgroundColor: AppColors.thirdColor,
          foregroundColor: AppColors.stylishText,
          child: Icon(Icons.add, color: AppColors.stylishText, size: 32),
        ),
      ),
    );
  }
}
