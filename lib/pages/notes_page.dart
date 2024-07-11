import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_2/components/my_drawer.dart';
import 'package:notes_app_2/components/my_note_tile.dart';
import 'package:notes_app_2/models/note.dart';
import 'package:notes_app_2/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller to access what the user typed
 final textController = TextEditingController();


 @override
  void initState() {

    super.initState();
    // on app starting, fetch existing notes
    readNotes();
  }


  // create a note
void createNote(){
  showDialog(

      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          // create buttons
          MaterialButton(
              onPressed: () {
                // add to db
                context.read<NoteDatabase>().addNote(textController.text);

                // clear controller
                textController.clear();

                // pop
                Navigator.pop(context);
              },
            child: const Text("Create"),
          )
        ],
      )
  );
}

  // read a note
 void readNotes(){
  context.read<NoteDatabase>().fetchNotes();
 }


  // update a note
 void updateNote(Note note){
   // pre-fill the current note
   textController.text = note.text;

   showDialog(
       context: context,
       builder: (context) => AlertDialog(
         title: const Text("Update Note"),
         content: TextField(controller: textController,),
         actions: [
           // update btn
           MaterialButton(
               onPressed: (){
                 context.read<NoteDatabase>().updateNotes(note.id, textController.text);
                 textController.clear();
                 Navigator.pop(context);
               },
             child: const Text("Update"),
           )
         ],
       )
   );
 }


  // delete a note
void deleteNote(int id){
   context.read<NoteDatabase>().deleteNote(id);
}

  @override
  Widget build(BuildContext context) {
    // note db
    final noteDatabase = context.watch<NoteDatabase>();
    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer:const MyDrawer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("Notes",
            style: GoogleFonts.ptSerif(
              fontSize: 48,
              color: Theme.of(context).colorScheme.inversePrimary
            ),
            ),
          ),
          // Notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
                itemBuilder: (context, index){
                  // get individual note
                  final note = currentNotes[index];
            
                  // return the list
                  return MyNoteTile(
                      text: note.text,
                    onEditPressed: () => updateNote(note),
                    onDelPressed: () => deleteNote(note.id),

                  );
                }
            ),
          ),
        ],
      ),
      
    );
  }
}
