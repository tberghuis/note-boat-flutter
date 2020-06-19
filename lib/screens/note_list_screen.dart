import 'package:flutter/material.dart';
import 'package:notes/blocs/note_list_bloc.dart';
import 'package:notes/screens/note_edit_screen.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<NoteListBloc>(
      create: (_) => NoteListBloc(),
      lazy: false,
      dispose: (_, bloc) => bloc.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Note Boat'),
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
              builder: (_) => NoteEditScreen(null),
            ),
          ),
        ),
      ),
    );
  }
}

// doing it wrong...

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteListBloc nlBloc = Provider.of<NoteListBloc>(context, listen: false);

    // TODO streambuilder
    return Text('note list blend');
  }
}
