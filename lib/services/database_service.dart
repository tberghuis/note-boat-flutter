import 'dart:io';
import 'package:notes/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();
  static Database _db;

  DatabaseService._instance();

  // table note
  // cols:
  // note_id
  // note_text
  // // created_date
  // modified_date

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/notes.db';

    print('notes path: $path');

    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE note(note_id INTEGER PRIMARY KEY AUTOINCREMENT, note_text TEXT, modified_date TEXT)',
    );
  }

  Future<List<Note>> getNoteList() async {
    // TODO
    Database db = await this.db;
    final List<Note> noteList = [];

    return noteList;
  }
}
