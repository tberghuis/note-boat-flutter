import 'package:notes/models/note_model.dart';
import 'package:notes/services/database_service.dart';

// TODO use provider, streams and dispose controllers

class NoteListBloc {
  // DatabaseService ds;

  static final NoteListBloc instance = NoteListBloc._instance();
  NoteListBloc._instance();

  // Future<List<Note>> Function() getNoteList = () => DatabaseService.instance.getNoteList();

  Future<List<Note>> Function() getNoteList =
      DatabaseService.instance.getNoteList;
}
