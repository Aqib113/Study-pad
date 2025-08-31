import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/database/models.dart';
// TaskShowcase is a widget that displays a single task with a checkbox and its title.
class TaskShowcase extends StatefulWidget {
  // The text/title of the task.
  final String task;
  // The current status of the task (checked or not).
  final TaskStatus taskStatus;
  // To check for the selction mode
  final bool selectionMode;
  // The ID of the task.
  final int taskId;
  // List of selected items.
  final List<int> selectedItemsList;
  // Callback function to handle checkbox state for TaskSTATUS.
  final ValueChanged<bool?>? changeStatus;
  // Callback function to handle checkbox state for SELECTION.
  final ValueChanged<bool?>? updateSelection;

  final void Function()? deleteTask;

  // Constructor for TaskShowcase, requires task, status, and onChange callback.
  const TaskShowcase({
    Key? key,
    required this.task,
    required this.taskStatus,
    required this.selectionMode,
    required this.taskId,
    required this.selectedItemsList,
    required this.changeStatus,
    required this.updateSelection,
    required this.deleteTask,
  }) : super(key: key);

  @override
  State<TaskShowcase> createState() => _TaskShowcaseState();
}

class _TaskShowcaseState extends State<TaskShowcase> {
  Widget StatusMarkBox(bool selectionMode) {
    return selectionMode
        ? Container(width: 10)
        : Container(
            width: 60,
            height: 60,
            child: Transform.scale(
              scale: 1.1, // Makes the checkbox larger.
              child: Checkbox(
                value: widget.taskStatus == TaskStatus.pending
                    ? false
                    : true, // Whether the checkbox is checked.
                onChanged: widget.changeStatus, // Calls parent callback on change.
                activeColor: AppColors.secondaryColor, // Color when checked.
                checkColor: AppColors.highlightColor1, // Checkmark color.
                shape:  const CircleBorder(),

              ),
            ),
          );
  }

  Widget DeleteButton(bool selectionMode) {
    return selectionMode
        ? Container(
            width: 60,
            height: 60,
            child: Transform.scale(
              scale: 1.1, // Makes the checkbox larger.
              child: Checkbox(
                value: widget.selectedItemsList.contains(widget.taskId), // Whether the checkbox is checked.
                onChanged: widget.updateSelection, // Calls parent callback on change.
                activeColor: AppColors.primaryColor, // Color when checked.
                checkColor: AppColors.white, // Checkmark color.
              ),
            ),
          )
        : Container();
        // : IconButton(
        //     onPressed: widget.deleteTask,
        //     icon: Icon(Icons.delete, size: 22, color: AppColors.dullWhite),
        //   );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // Outer margin for spacing between tasks.
      margin: EdgeInsets.only(top: 10),
      // Inner padding for content spacing.
      padding: EdgeInsets.only(left: 5, top: 2, bottom: 2, right: 3),
      // Rounded background for the task container.
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),

      child: Row(
        children: [
          // Container to size and scale the checkbox.
          StatusMarkBox(widget.selectionMode),

          // The task text/title.
          Expanded(
            child: Text(
              widget.task,
              style: TextStyle(
                color: AppColors.white,
                fontFamily: 'montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Button to delete Particular task
          DeleteButton(widget.selectionMode),
        ],
      ),
    );
  }
}
