import 'dart:async';

import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteEditBloc {
  DatabaseService _ds = DatabaseService.instance;
  // Completer _noteCompleter = new Completer<Note>();
  // Future<Note> get initialisedNote {
  //   return _noteCompleter.future;
  // }

  Future<Note> initialisedNote;

  NoteEditBloc(int noteId) {
    initialisedNote = init(noteId);
  }

  Future<Note> init(int noteId) async {
    Note note = Note(noteId: noteId);

    // new note
    if (noteId == null) {
      print('inserting note');
      await _ds.insertNote(note);
    }
    return note;
  }

  // Future<void> init(int noteId) async {
  //   // TODO
  //   // if noteid not null fetch note from db
  //   Note note = Note(noteId: noteId);

  //   // new note
  //   if (noteId == null) {
  //     print('inserting note');
  //     await _ds.insertNote(note);

  //     // print('noteId ${note.noteId}');
  //   }
  //   // initialisedNote = Future<Note>.value(note);
  //   _noteCompleter.complete(note);
  // }

  // TODO on back delete note if text is only whitespace

  onNoteChanged(String noteText) async {
    Note n = await initialisedNote;

    // no change return or whitespace (TODO)
    if (n.noteText == noteText) {
      return;
    }

    n.noteText = noteText;
    _ds.updateNote(n);
  }

  Future<bool> onWillPop() async {
    Note n = await initialisedNote;
    if (n.noteText.replaceAll(new RegExp(r"\s"), "").length == 0) {
      // delete from db, no need to await
      _ds.deleteNote(n);
    }
    return true;
  }

  dispose() {
    // _textController.close();
  }
}
