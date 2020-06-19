import 'dart:async';

import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteEditBloc {
  DatabaseService _ds = DatabaseService.instance;
  Completer _noteCompleter = new Completer<Note>();
  Future<Note> get initialisedNote {
    return _noteCompleter.future;
  }

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

      // print('noteId ${note.noteId}');
    }
    // initialisedNote = Future<Note>.value(note);
    _noteCompleter.complete(note);
  }

  // TODO on back delete note if text is only whitespace

}
