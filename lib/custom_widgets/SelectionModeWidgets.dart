import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';


class HeadingText extends StatelessWidget {
  const HeadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Select Tasks . . .',
      style: TextStyle(
        color: AppColors.headingColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'montserrat',

      ),
      textAlign: TextAlign.left,
    );
  }
}


