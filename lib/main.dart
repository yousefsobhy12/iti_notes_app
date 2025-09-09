import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/folder_model.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:notes_app/screens/notes_screen.dart';
import 'package:notes_app/style/app_themes.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(FolderModelAdapter());
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider()
        ..getData()
        ..getIsDark(),
      child: Consumer<NotesProvider>(
        builder: (context, value, child) {
          final provider = context.read<NotesProvider>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: provider.isDark ? AppThemes.darkTheme : AppThemes.lightTheme,
            home: NotesScreen(),
          );
        },
      ),
    );
  }
}
