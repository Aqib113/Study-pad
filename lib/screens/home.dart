import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/screens/tasks.dart';
import 'package:notesapp/screens/notes.dart';
import 'package:notesapp/custom_widgets/BottomNavigationBar.dart';
import 'package:notesapp/custom_widgets/CustomAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VARIABLES
  int current_index = 0;

  // FUNCTIONS
  void NavTo(index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(currentIndex: current_index),
      body:
          // Indexed Stack for tracking the pages
          IndexedStack(
            index: current_index,
            children: [NotesPage(), TaskPage()],
          ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: NavTo,
        currentIndex: current_index,
      ),
    );
  }
}
