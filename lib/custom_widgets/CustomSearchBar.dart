import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';

// CustomSearchBar is a reusable search bar widget for the app.
class CustomSearchBar extends StatelessWidget {
  // Controller to manage the text input in the search bar
  final TextEditingController Req_controller;

  // Constructor requires a controller from the parent widget
  CustomSearchBar({Key? key, required this.Req_controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding around the search bar for spacing
      padding: EdgeInsets.only(left: 12, top: 5, right: 5, bottom: 5),
      margin: EdgeInsets.only(bottom: 15),
      // Rounded background for the search bar
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Search icon at the start of the bar
          Icon(Icons.search, size: 32, color: AppColors.white),
          // The text field where user types their search query
          Expanded(
            child: TextField(
              controller:Req_controller, // Connects the text field to the controller
              style: TextStyle(
                color: AppColors.white, // Text color inside the search bar
                fontSize: 18,
                fontFamily: 'poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Search Here', // Placeholder text
                hintStyle: TextStyle(
                  color: AppColors.white, // Lighter hint color
                  fontSize: 18,
                  fontFamily: 'poppins',
                ),
                contentPadding: EdgeInsets.all(6), // Padding inside the text field
                // Border when not focused (invisible)
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent),
                ),
                // Border when focused (invisible)
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
