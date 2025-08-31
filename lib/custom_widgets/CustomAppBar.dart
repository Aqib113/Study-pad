import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';
import 'package:notesapp/database/models.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int currentIndex;

  CustomAppBar({Key? key, required this.currentIndex}) : super(key: key);

  // Required for PreferredSizeWidget to set AppBar height
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

// CustomAppBar is a reusable app bar that changes its title based on the selected tab.
class _CustomAppBarState extends State<CustomAppBar> {
  // Titles for each tab
  final List<String> appBarTitles = ['Notes', 'Tasks'];

  @override
  Widget build(BuildContext context) {
    return Container(
      // AppBar background color and padding
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      padding: const EdgeInsets.only(left: 15.0, top: 5, right: 5),
      child: Consumer2<SelectionMode, SelectedItems>(
        builder: (context, selectionMode, selectedItems, child) => AppBar(
          backgroundColor: AppColors.secondaryColor,
          // Dynamic title based on currentIndex
          title: selectionMode.selectionModeValue
              ? IconButton(
                  onPressed: () => setState(() {
                    selectionMode.ToggleSelectionMode(false, context);
                  }),
                  icon: const Icon(Icons.close),
                  color: AppColors.white,
                )
              : Text(
                  appBarTitles[widget.currentIndex],
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'montserrat',
                  ),
                ),
          // Settings button on the right
          actions: [
            selectionMode.selectionModeValue
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Selected All',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'montserrat',
                        ),
                      ),
                      Checkbox(
                        value: selectionMode.isAllTaskSelected,
                        onChanged: (value) => setState(() {
                          selectionMode.ToggleAllTaskSelection(value, context);
                        }),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    icon: const Icon(Icons.settings_sharp),
                    iconSize: 24,
                    color: AppColors.white,
                  ),
          ],
        ),
      ),
    );
  }
}
