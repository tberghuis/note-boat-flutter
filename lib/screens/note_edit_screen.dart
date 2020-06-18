import 'package:flutter/material.dart';
import 'package:notes/blocs/note_edit_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatelessWidget {
  final int _noteId;
  NoteEditScreen(this._noteId);

  @override
  Widget build(BuildContext context) {
    // NoteEditBloc noteEditBloc;

    return Provider(
        create: (_) => NoteEditBloc(_noteId),
        // create: (_) {
        //   print('provider create');
        //   return NoteEditBloc(_noteId);
        // },
        lazy: false,
        child: Scaffold(
          appBar: AppBar(
              // title: Text('Note Ed'),
              ),
          body: Container(
            child: NoteEditBody(),

            // FutureBuilder(
            //   future: noteEditBloc.initialisedNote,
            // ),
          ),
        ));
  }
}

class NoteEditBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteEditBloc neb = Provider.of<NoteEditBloc>(context, listen: false);

    return FutureBuilder<Note>(
        future: neb.initialisedNote,
        builder: (BuildContext context, AsyncSnapshot<Note> snapshot) {
          print('snapshot $snapshot');
          print('snapshot.data ${snapshot.data}');

          return Dummy(snapshot.data);
        });
  }
}

class Dummy extends StatelessWidget {
  final Object o;
  Dummy(this.o);

  @override
  Widget build(BuildContext context) {
    print('o $o');
    return Text('will object blend');
  }
}
