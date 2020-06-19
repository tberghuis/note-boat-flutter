import 'dart:async';

import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

// TODO use provider, streams and dispose controllers

// don't be a singleton...

class NoteListBloc {
  DatabaseService ds = DatabaseService.instance;

  final _noteList = StreamController<List<Note>>();

  Stream<List<Note>> get noteListStream => _noteList.stream;

  NoteListBloc() {
    () async {
      List<Note> allNotes = await ds.getNoteList();
      _noteList.sink.add(allNotes);
    }();
  }

  dispose() {
    _noteList.close();
  }
}
