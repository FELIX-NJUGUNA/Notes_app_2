import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:notes_app_2/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  // INITIALIZE DB
   static Future<void> initialize() async {
     final dir = await getApplicationDocumentsDirectory();
     isar = await Isar.open([NoteSchema], directory: dir.path);
   }

   // notes list
final List<Note> currentNotes = [];

  // CREATE
Future<void> addNote(String text) async {
  final newNote = Note()..text = text;

  // save
  await isar.writeTxn(() => isar.notes.put(newNote));
  
  // re-read db
  fetchNotes();
}


  // READ
Future<void> fetchNotes() async {
  List<Note> fetchedNotes = await isar.notes.where().findAll();
  currentNotes.clear();
  currentNotes.addAll(fetchedNotes);
  notifyListeners();
}


  // UPDATE
  Future<void> updateNotes(int id, String newText) async{
  final existingNote = await isar.notes.get(id);
  if(existingNote != null){
    existingNote.text = newText;
    await isar.writeTxn(() => isar.notes.put(existingNote));
    await fetchNotes();
  }
  }



// DELETE

  Future<void> deleteNote(int id) async {
  await isar.writeTxn(() => isar.notes.delete(id));
  await fetchNotes();
  }

}