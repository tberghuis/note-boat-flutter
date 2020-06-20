import 'package:flutter/material.dart';
import 'package:notes/blocs/note_list_bloc.dart';
import 'package:notes/models/note_model.dart';
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

// anyway to consume provider without child widget???

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteListBloc nlBloc = Provider.of<NoteListBloc>(context, listen: false);

    // TODO streambuilder
    // return Text('note list blend');
    return StreamBuilder(
        stream: nlBloc.noteListStream,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data == null) {
            return SizedBox.shrink();
          }

          List<Note> nl = asyncSnapshot.data;

          print('asyncSnapshot.data ${asyncSnapshot.data}');
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: nl.length,
            itemBuilder: (context, index) {
              return Container(child: Text(getFirstLine(nl[index].noteText)));
            },
          );
        });
  }
}

String getFirstLine(String note) {
  return note.trim().split('\n')[0];
}
