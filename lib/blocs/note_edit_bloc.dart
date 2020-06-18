import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteEditBloc {
  // int _noteId;
  DatabaseService _ds = DatabaseService.instance;

  Future<Note> initialisedNote;

  NoteEditBloc(int noteId) {
    init(noteId);
  }

  Future<void> init(int noteId) async {
    // TODO
    // if noteid not null fetch note from db
    Note note = Note(noteId: noteId);

    // new note
    if (noteId == null) {

      print('inserting note');
      await _ds.insertNote(note);
    }
    initialisedNote = Future<Note>.value(note);
  }

  // TODO on back delete note if text is only whitespace

}
