import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';

// This is a custom BottomNavigationBar widget used throughout the app.
// It allows switching between different pages (e.g., Notes and Tasks).
class CustomBottomNavigationBar extends StatelessWidget {
  // Callback function to handle tab changes.
  final Function(int) onTap;
  // The currently selected tab index.
  final int currentIndex;

  // Constructor with required parameters.
  const CustomBottomNavigationBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The Container adds background color and padding to the navigation bar.
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      // Adds padding only to the top of the navigation bar.
      padding: EdgeInsets.only(top: 10),
      // Theme widget is used to remove the splash effect on tap.
      child: Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child:
            // The actual BottomNavigationBar widget.
            BottomNavigationBar(
              selectedFontSize: 16, // Font size for selected tab label.
              unselectedFontSize: 14, // Font size for unselected tab label.
              selectedItemColor:AppColors.highlightColor1, // Color for selected icon/label.
              unselectedItemColor: AppColors.white, // Color for unselected icon/label.
              backgroundColor:  AppColors.secondaryColor, // Background color of the bar.
              elevation: 0, // Removes shadow.
              onTap: onTap, // Calls the provided function when a tab is tapped.

              
              currentIndex: currentIndex, // Indicates which tab is currently selected.
              items: const [
                // First tab: Notes
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notes_outlined,
                    color: AppColors.white,
                    size: 32,
                  ),
                  label: "Notes",
                ),
                // Second tab: Tasks
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task_alt_outlined,
                    color: AppColors.white,
                    size: 32,
                  ),
                  label: "Tasks",
                ),
              ],
            ),
      ),
    );
  }
}
