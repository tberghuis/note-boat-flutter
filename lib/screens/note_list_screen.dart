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
      child: NoteList(),
    );
  }
}

// doing it wrong...

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteListBloc nlBloc = Provider.of<NoteListBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Note Boat'),
      ),
      body: Container(
        child: StreamBuilder(
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
                  return Card(
                    child: ListTile(
                      title: Text(
                        getFirstLine(nl[index].noteText),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onTap: () =>
                          navigateNoteEditScreen(context, nl[index], nlBloc),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          // push named??? nah
          onPressed: () =>
              navigateNoteEditScreen(context, Note.create(), nlBloc)),
    );
  }
}

String getFirstLine(String note) {
  return note.trim().split('\n')[0];
}

Future<void> navigateNoteEditScreen(
  context,
  Note note,
  NoteListBloc nlBloc,
) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => NoteEditScreen(note),
    ),
  );
  nlBloc.refreshNoteList();
}
