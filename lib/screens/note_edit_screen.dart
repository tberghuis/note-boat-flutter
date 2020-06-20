import 'package:flutter/material.dart';
import 'package:notes/blocs/note_edit_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatelessWidget {
  final Note _note;
  NoteEditScreen(this._note);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => NoteEditBloc(_note),
        lazy: false,
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            child: NoteEditBody(),
          ),
        ));
  }
}

class NoteEditBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteEditBloc neb = Provider.of<NoteEditBloc>(context, listen: false);

    return WillPopScope(
      onWillPop: neb.onWillPop,
      child: FutureBuilder<Note>(
        future: neb.initialisedNote,
        builder: (BuildContext context, AsyncSnapshot<Note> snapshot) {
          Note n = snapshot.data;
          if (n == null) {
            return Container();
          }
          return TextFormField(
            initialValue: n.noteText,
            onChanged: neb.onNoteChanged,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
          );
        },
      ),
    );
  }
}

// class Dummy extends StatelessWidget {
//   final Object o;
//   Dummy(this.o);

//   @override
//   Widget build(BuildContext context) {
//     print('o $o');
//     return Text('will object blend');
//   }
// }
