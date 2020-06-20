import 'dart:async';

import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteEditBloc {
  DatabaseService _ds = DatabaseService.instance;

  Future<Note> initialisedNote;

  // NoteEditBloc(int noteId) {
  //   initialisedNote = _init(noteId);
  // }
  NoteEditBloc(Note note) {
    initialisedNote = _init(note);
  }

  // only called from constructor
  Future<Note> _init(Note note) async {
    // Note note = Note(noteId: noteId);

    // new note
    if (note.noteId == null) {
      print('inserting note');
      await _ds.insertNote(note);
    }

    return note;
  }

  onNoteChanged(String noteText) async {
    Note n = await initialisedNote;
    // no change return or whitespace (TODO)
    if (n.noteText == noteText) {
      return;
    }

    n.noteText = noteText;
    _ds.updateNote(n);
  }

  // on back delete note if text is only whitespace
  Future<bool> onWillPop() async {
    Note n = await initialisedNote;
    if (n.noteText.replaceAll(new RegExp(r"\s"), "").length == 0) {
      // delete from db, no need to await
      await _ds.deleteNote(n);
    }
    return true;
  }

  dispose() {
    // _textController.close();
  }
}
