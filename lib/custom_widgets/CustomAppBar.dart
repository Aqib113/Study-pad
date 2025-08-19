import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';

// CustomAppBar is a reusable app bar that changes its title based on the selected tab.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Index of the currently selected tab (0 = Notes, 1 = Tasks)
  final int currentIndex;

  // Constructor requires the current tab index
  CustomAppBar({Key? key, required this.currentIndex}) : super(key: key);

  // Titles for each tab
  final List<String> appBarTitles = ['Notes', 'Tasks'];

  // Required for PreferredSizeWidget to set AppBar height
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      // AppBar background color and padding
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      padding: const EdgeInsets.only(left: 15.0, top: 5, right: 5),
      child: AppBar(
        backgroundColor: AppColors.secondaryColor,
        // Dynamic title based on currentIndex
        title: Text(
          appBarTitles[currentIndex],
          style: TextStyle(
            color: AppColors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            fontFamily: 'poppins',
          ),
        ),
        // Settings button on the right
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: Icon(Icons.settings_sharp),
            iconSize: 36,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
