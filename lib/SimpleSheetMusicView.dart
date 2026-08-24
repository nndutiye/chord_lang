import 'package:chord_lang/model/MidiValue.dart';
import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

class SimpleSheetMusicView extends StatefulWidget {
  const SimpleSheetMusicView(List<String> this.chords_to_show, {super.key});
  final List<String> chords_to_show;
  @override
  State<StatefulWidget> createState() => SimpleSheetMusicViewState(chords_to_show);
}

class SimpleSheetMusicViewState extends State {
  SimpleSheetMusicViewState(List<String> list) {
    this.chord_notes = list;
  }
  late final List<String> chord_notes;
  late final Measure measure1;
  late final Measure measure2;

  @override
  void initState() {
    MidiValue mv = MidiValue();
    print(chord_notes[0]);
    //print("Pitch:");
    measure1 = Measure([
      const Clef(ClefType.treble),
      const KeySignature(KeySignatureType.cMajor),
      ChordNote([
        ChordNotePart(mv.getPitchByStringNeutral(chord_notes[0])),
        ChordNotePart(mv.getPitchByStringNeutral(chord_notes[1])),
        ChordNotePart(mv.getPitchByStringNeutral(chord_notes[2])),
      ]),
      const Rest(RestType.quarter),
      const Note(Pitch.a4,
          noteDuration: NoteDuration.sixteenth, accidental: Accidental.flat),
      const Rest(RestType.sixteenth),
    ]);
    measure2 = Measure([
      const ChordNote([
        ChordNotePart(Pitch.c4),
        ChordNotePart(Pitch.c5),
      ], noteDuration: NoteDuration.sixteenth),
      const Note(Pitch.a4,
          noteDuration: NoteDuration.sixteenth, accidental: Accidental.flat)
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sheetMusicSize = MediaQuery.of(context).size;
    final width = sheetMusicSize.width * 0.75;
    final height = sheetMusicSize.height * 0.5 * 0.75;
    return SimpleSheetMusic(
              height: height,
              width: width,
              measures: [measure1, measure2],
            );
  }
}