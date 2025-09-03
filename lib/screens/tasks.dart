import 'package:flutter/material.dart';
import 'package:notesapp/database/Hive.dart';
import 'package:notesapp/database/models.dart';
import 'package:notesapp/custom_widgets/TasksShowCase.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/custom_widgets/CustomSearchBar.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/custom_widgets/SelectionModeWidgets.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPage();
}

class _TaskPage extends State<TaskPage> {
  TextEditingController SearchBar_controller = TextEditingController();
  TextEditingController _TaskInputController = TextEditingController();
  bool _EnabledToAddTask = false;
  final FocusNode _focusNodeForSearchBar = FocusNode();
  OverlayEntry? _overlayEntry;
  List<Task> tasks = [];
  // selectedItemsList

  void initState() {
    super.initState();
    _TaskInputController.addListener(() {
      setState(() {
        _EnabledToAddTask = _TaskInputController.text.isNotEmpty;
      });
    });
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
    await TaskManager.changeStatus(key, value);
    getAllTasks();
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
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    alignment: Alignment.center,
                    child: TextField(
                      autofocus: true,
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
                        onPressed: _EnabledToAddTask ? saveNewTask : null,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: _EnabledToAddTask
                                ? AppColors.stylishText
                                : AppColors.thirdColor,
                          ),
                        ),
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
    
  void DeleteSelectedTasks() async {
    List<int> tasksToDelete = Provider.of<SelectedItems>(
      context,
      listen: false,
    ).selectedItemsList;
    for (var task in tasksToDelete) {
      await deleteTasks(task);
    }
    Provider.of<SelectionMode>(context, listen: false).ToggleSelectionMode(false, context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer2<SelectionMode, SelectedItems>(
        builder: (context, selectionMode, selectedItems, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.primaryColor,
          body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                selectionMode.selectionModeValue
                    ? HeadingText()
                    : CustomSearchBar(
                        Req_controller: SearchBar_controller,
                        focusNode: _focusNodeForSearchBar,
                      ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                      tasks.length,
                      (index) => GestureDetector(
                        onLongPress: () =>
                            selectionMode.ToggleSelectionMode(true, context),
                        child: TaskShowcase(
                          task: tasks[index].title,
                          taskStatus: tasks[index].status,
                          selectionMode: selectionMode.selectionModeValue,
                          taskId: tasks[index].key,
                          selectedItemsList: selectedItems.selectedItemsList,
                          changeStatus: (bool? value) {
                            ChangeStatus(tasks[index].key, value);
                          },
                          updateSelection: (bool? _value) {
                            selectedItems.UpdateSelection(
                              _value,
                              tasks[index].key,
                            );
                            setState(() {});
                            print('-------------------------------------');
                            print(selectedItems.selectedItemsList);
                          },
                          deleteTask: () {
                            deleteTasks(tasks[index].key);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: selectionMode.selectionModeValue
                ? DeleteSelectedTasks
                : ShowAddNewTaskInput,
            elevation: 0,
            backgroundColor: AppColors.thirdColor,
            foregroundColor: AppColors.stylishText,
            child: selectionMode.selectionModeValue
                ? Icon(Icons.delete, color: AppColors.stylishText, size: 32)
                : Icon(Icons.add, color: AppColors.stylishText, size: 32),
          ),
        ),
      ),
    );
  }
}
