class Note {
  int noteId;
  String noteText;
  // DateTime created_date;
  DateTime modifiedDate;

  Note({this.noteId, this.noteText, this.modifiedDate}) {
    if (noteText == null) {
      noteText = "";
    }
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (noteId != null) {
      map['note_id'] = noteId;
    }
    map['note_text'] = noteText;
    map['modified_date'] = modifiedDate.toIso8601String();
    return map;
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        noteId: map['note_id'],
        noteText: map['note_text'],
        modifiedDate: DateTime.parse(map['modified_date']));
  }
}
