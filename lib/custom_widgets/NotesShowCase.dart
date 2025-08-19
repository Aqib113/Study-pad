import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';

class NotesShowCase extends StatefulWidget {
  final String title;
  final String content;
  final String lastModified;
  final void Function()? OnTap;
  NotesShowCase({
    required this.title,
    required this.content,
    required this.lastModified,
    required this.OnTap,
    Key? key,
  }) : super(key: key);

  @override
  State<NotesShowCase> createState() => _NotesShowCaseState();
}

class _NotesShowCaseState extends State<NotesShowCase> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.OnTap,
      child: Container(
        // Outer margin for spacing between tasks.
        margin: EdgeInsets.only(top: 10),
        // Inner padding for content spacing.
        padding: EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 16),
        // Rounded background for the task container.
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.edit, color: AppColors.dullWhite, size: 28),
                    SizedBox(width: 10),
                    (Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),)
                    ),
                  ],
                ),

                Text(
                  widget.lastModified,
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            Text(
              widget.content,
              style: TextStyle(
                color: AppColors.dullWhite,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
