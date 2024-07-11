import 'package:flutter/material.dart';
import 'package:notes_app_2/models/note_database.dart';
import 'package:notes_app_2/pages/notes_page.dart';
import 'package:notes_app_2/theme/theme_provider.dart';
import 'package:provider/provider.dart';



void main() async {
  // initialize isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();


  runApp(
    MultiProvider(
        providers: [
          // Note Providers
            ChangeNotifierProvider(create: (context) => NoteDatabase()),

          // Theme Providers
          ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
      child: const MyApp(),
    )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotesPage(),
    );
  }
}

