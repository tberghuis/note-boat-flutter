import 'dart:io';
import 'package:notes/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<void> _createDb(Database db, int version) async {
  await db.execute(
    'CREATE TABLE note(note_id INTEGER PRIMARY KEY AUTOINCREMENT, note_text TEXT, modified_date TEXT, created_date TEXT)',
  );
}

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();

  final Future<Database> _dbFuture = () async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/notes.db';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }();

  DatabaseService._instance();


  // should i contain this here.... better to put in bloc if not
  // reused by multiple screens
  // nah just copy from simple example for now

  Future<List<Note>> getNoteList() async {
    // TODO
    // delete empty notes
    // Database db = await this.db;
    final List<Note> noteList = [];

    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database db = await _dbFuture;
    note.modifiedDate = DateTime.now();
    // catch exception????
    final int result = await db.insert('note', note.toMap());
    note.noteId = result;
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database db = await _dbFuture;
    note.modifiedDate = DateTime.now();
    final int result = await db.update(
      'note',
      note.toMap(),
      where: 'note_id = ?',
      whereArgs: [note.noteId],
    );
    return result;
  }

  Future<int> deleteNote(Note note) async {
    Database db = await _dbFuture;
    final int result = await db.delete(
      'note',
      where: 'note_id = ?',
      whereArgs: [note.noteId],
    );
    return result;
  }
}
