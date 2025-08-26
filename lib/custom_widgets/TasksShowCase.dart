import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/database/models.dart';

// TaskShowcase is a widget that displays a single task with a checkbox and its title.
class TaskShowcase extends StatefulWidget {
  // The text/title of the task.
  final String task;
  // The current status of the task (checked or not).
  final TaskStatus taskStatus;
  // Callback function to handle checkbox state changes.
  final ValueChanged<bool?>? onChange;
  final void Function()? deleteTask;

  // Constructor for TaskShowcase, requires task, status, and onChange callback.
  const TaskShowcase({
    Key? key,
    required this.task,
    required this.taskStatus,
    required this.onChange,
    required this.deleteTask,
  }) : super(key: key);

  @override
  State<TaskShowcase> createState() => _TaskShowcaseState();
}

class _TaskShowcaseState extends State<TaskShowcase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // Outer margin for spacing between tasks.
      margin: EdgeInsets.only(top: 10),
      // Inner padding for content spacing.
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
      // Rounded background for the task container.
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          // Container to size and scale the checkbox.
          Container(
            width: 60,
            height: 60,
            child: Transform.scale(
              scale: 1.1, // Makes the checkbox larger.
              child: Checkbox(
                value: widget.taskStatus == TaskStatus.pending
                    ? false
                    : true, // Whether the checkbox is checked.
                onChanged: widget.onChange, // Calls parent callback on change.
                activeColor: AppColors.primaryColor, // Color when checked.
                checkColor: AppColors.white, // Checkmark color.
              ),
            ),
          ),

          // The task text/title.
          Expanded(
            child: Text(
              widget.task,
              style: TextStyle(
                color: AppColors.white,
                fontFamily: 'poppins',
                fontSize: 18,
              ),
            ),
          ),

          // Button to delete Particular task
          IconButton(
            onPressed: widget.deleteTask,
            icon: Icon(Icons.delete, size: 22, color: AppColors.dullWhite),
          ),
        ],
      ),
    );
  }
}
