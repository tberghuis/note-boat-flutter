import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteEditBloc {
  // int _noteId;
  DatabaseService _ds = DatabaseService.instance;

  Future<Note> initialisedNote;

  NoteEditBloc(int noteId) {
    // TODO
    // if noteid not null fetch note from db
    Note note = Note(noteId: noteId);

    // new note
    if (noteId == null) {
      _ds.insertNote(note);
    }
  }

  // TODO on back delete note if text is only whitespace

}
