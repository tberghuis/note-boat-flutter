import 'package:flutter/material.dart';

class NoteEditScreen extends StatefulWidget {
  int noteId;

  NoteEditScreen(this.noteId);
  //  {
  //   print('noteid $noteId');
  //   // if noteId null this is a new note
  // }

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('noteid ${widget.noteId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Note Ed'),
          ),
      body: Container(
        child: Text('note edit'),
      ),
    );
  }
}
