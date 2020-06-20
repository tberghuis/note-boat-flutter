import 'dart:async';

import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

class NoteListBloc {
  DatabaseService ds = DatabaseService.instance;

  final _noteList = StreamController<List<Note>>();

  Stream<List<Note>> get noteListStream => _noteList.stream;

  NoteListBloc() {
    print('NoteListBloc');

    refreshNoteList();
  }

  Future<void> refreshNoteList() async {
    List<Note> allNotes = await ds.getNoteList();
    _noteList.sink.add(allNotes);
  }

  dispose() {
    _noteList.close();
  }
}
