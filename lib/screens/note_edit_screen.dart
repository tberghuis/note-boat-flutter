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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: NoteEditBody(),
          ),
        ),
      ),
      // this should somehow be derived from theme
      backgroundColor: Color(0xffe8f7ff),
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
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration.collapsed(hintText: 'new note text...'),
        initialValue: neBloc.note.noteText,
        onChanged: neBloc.onNoteChanged,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autofocus: neBloc.note.noteId == null,
      ),
    );
  }
}

Future<void> _deleteDialog(context, NoteEditBloc neBloc) async {
  if (neBloc.isEmptyNote()) {
    await neBloc.deleteNote();
    Navigator.of(context).pop();
    return;
  }
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
