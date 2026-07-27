import 'package:chord_lang/model/Note.dart';

class Notes {
  Notes() {
    generateNoteObjectList();
  }
  List<Note> allSevenNotesAsNoteObject = [] ;
  List<String> allSevenNotesAsString = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];

  void generateNoteObjectList() {
    for (String n in this.allSevenNotesAsString) {
      this.allSevenNotesAsNoteObject.add(Note(n));
    }
  }


  List<String> getAllNotesAsString() => this.allSevenNotesAsString;
}