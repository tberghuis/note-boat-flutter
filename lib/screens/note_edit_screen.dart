import 'package:flutter/material.dart';
import 'package:notes/blocs/note_edit_bloc.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatelessWidget {
  final int _noteId;
  NoteEditScreen(this._noteId);

  @override
  Widget build(BuildContext context) {
    return Provider(
        // create: (_) => NoteEditBloc(_noteId),
        create: (_) {
          print('provider create');
          NoteEditBloc(_noteId);
        },
        lazy: false,
        child: Scaffold(
          appBar: AppBar(
              // title: Text('Note Ed'),
              ),
          body: Container(
            child: Text('note edit'),
          ),
        ));
  }
}

// class NoteEditScreen extends StatefulWidget {
//   int noteId;
//   NoteEditScreen(this.noteId);
//   @override
//   _NoteEditScreenState createState() => _NoteEditScreenState();
// }

// class _NoteEditScreenState extends State<NoteEditScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print('noteid ${widget.noteId}');
//   }

//   @override
//   Widget build(BuildContext context) {

//   }
// }
