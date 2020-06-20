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
    NoteEditBloc neBloc = Provider.of<NoteEditBloc>(context, listen: false);

    return WillPopScope(
      onWillPop: neBloc.onWillPop,
      child: TextFormField(
        initialValue: neBloc.note.noteText,
        onChanged: neBloc.onNoteChanged,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autofocus: true,
      ),
    );
  }
}
