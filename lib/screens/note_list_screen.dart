import 'package:flutter/material.dart';
import 'package:notes/blocs/note_list_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/screens/note_edit_screen.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Container(
        child: NoteList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // TODO push named??? nah
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NoteEditScreen(),
          ),
        ),
      ),
    );
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  Future<List<Note>> _noteList;

  @override
  void initState() {
    super.initState();

    // DatabaseService.instance
    setState(() {
      _noteList = NoteListBloc.instance.getNoteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
