import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/database/models.dart';
import 'package:notesapp/screens/editNotes.dart';
import 'package:notesapp/screens/home.dart';
import 'package:notesapp/screens/settings.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskStatusAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('Taskbox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectionMode()),
        ChangeNotifierProvider(create: (context) => SelectedItems()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingPage(),
        '/EditNotes': (context) => EditNotesPage(),
      },
      home: const HomePage(),
    );
  }
}
