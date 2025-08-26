import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/custom_widgets/CustomSearchBar.dart';
import 'package:notesapp/custom_widgets/NotesShowCase.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPage();
}

class _NotesPage extends State<NotesPage> {
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final notes = [
    [
      'Title',
      'Content of the notes will be diplayed here like everything',
      '12/8/2025',
    ],
    [
      'Title',
      'Content of the notes will be diplayed here like everything',
      '12/8/2025',
    ],
  ];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomSearchBar(Req_controller: controller, focusNode: _focusNode,),
            ...List.generate(
              notes.length,
              (index) => NotesShowCase(
                title: notes[index][0],
                content: notes[index][1],
                lastModified: notes[index][2],
                OnTap: ()=>{
                  Navigator.pushNamed(context, '/EditNotes', arguments: index)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
