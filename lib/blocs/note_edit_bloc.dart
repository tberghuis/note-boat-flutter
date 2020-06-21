import 'dart:async';
import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteEditBloc {
  final DatabaseService _ds = DatabaseService.instance;
  final Note note;

  NoteEditBloc(this.note) {
    if (note.noteId == null) {
      print('create new note');
      _ds.insertNote(note);
    }
  }

  onNoteChanged(String noteText) async {
    // no change return or whitespace (TODO)
    if (note.noteText == noteText) {
      return;
    }

    note.noteText = noteText;
    _ds.updateNote(note);
  }

  // on back delete note if text is only whitespace
  // shouldn't contain UI logic here (i.e. pop)
  Future<bool> onWillPop() async {
    if (isEmptyNote()) {
      // delete from db, no need to await
      await _ds.deleteNote(note);
    }
    return true;
  }

  bool isEmptyNote() {
    return note.noteText.replaceAll(new RegExp(r"\s"), "").length == 0;
  }

  Future<void> deleteNote() async {
    print('delete note');
    await _ds.deleteNote(note);
  }

  // remove???
  dispose() {
    // _textController.close();
  }
}
