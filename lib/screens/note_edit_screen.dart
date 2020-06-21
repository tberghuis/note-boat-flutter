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
        child: NoteEditScaffold());
  }
}

class NoteEditScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteEditBloc neBloc = Provider.of<NoteEditBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Note',
            onPressed: () => _deleteDialog(context, neBloc),
          ),
        ],
      ),
      body: Container(
        child: NoteEditBody(),
      ),
    );
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

Future<void> _deleteDialog(context, neBloc) async {
  bool confirmDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('AlertDialog Title'),
        content: SingleChildScrollView(child: Text('Confirm Delete?')),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmDelete == true) {
    await neBloc.deleteNote();
    Navigator.of(context).pop();
  }

  // print('dialogRet $dialogRet');
}
