import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';

// CustomSearchBar is a reusable search bar widget for the app.
class CustomSearchBar extends StatelessWidget {
  // Controller to manage the text input in the search bar
  final TextEditingController Req_controller;
  final FocusNode focusNode;

  // Constructor requires a controller from the parent widget
  CustomSearchBar({
    Key? key,
    required this.Req_controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding around the search bar for spacing
      padding: EdgeInsets.only(left: 12, top: 3, right: 5, bottom: 3),
      margin: EdgeInsets.only(bottom: 15),
      // Rounded background for the search bar
      decoration: BoxDecoration(
        color: AppColors.searchBarBG,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Search icon at the start of the bar
          Icon(Icons.search, size: 26, color: AppColors.dullWhite),
          // The text field where user types their search query
          Expanded(
            child: TextField(
              controller:
                  Req_controller, // Connects the text field to the controller
              focusNode: focusNode,
              style: TextStyle(
                color: AppColors.white, // Text color inside the search bar
                fontSize: 16,
                fontFamily: 'poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Search Here', // Placeholder text
                hintStyle: TextStyle(
                  color: AppColors.dullWhite, // Lighter hint color
                  fontSize: 16,
                  fontFamily: 'poppins',

                ),
                contentPadding: EdgeInsets.all(
                  6,
                ), // Padding inside the text field
                // Border when not focused (invisible)
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent),
                ),
                // Border when focused (invisible)
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent),
                ),

              ),
              cursorColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
