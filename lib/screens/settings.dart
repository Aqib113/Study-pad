import 'package:flutter/material.dart';
import 'package:notesapp/custom_widgets/colors.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color:AppColors.white),
        elevation: 0,
      ),
      body: Center(child:Text("SETTINGS page", style: TextStyle(color: AppColors.white),))

    );
  }
}
