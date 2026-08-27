import 'package:chord_lang/model/MidiValue.dart';
import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

class SimpleSheetMusicView extends StatefulWidget {
  const SimpleSheetMusicView(List<String> this.chords_to_show, this.current_scale, {super.key});
  final List<String> chords_to_show;
  final String current_scale;
  @override
  State<StatefulWidget> createState() => SimpleSheetMusicViewState(chords_to_show, current_scale);
}

class SimpleSheetMusicViewState extends State {
  SimpleSheetMusicViewState(List<String> list, String current_scale) {
    this.chord_notes = list;
    this.current_scale = current_scale;
  }
  late final List<String> chord_notes;
  late final String current_scale;
  late final Measure measure1;

  @override
  void initState() {
    MidiValue mv = MidiValue();
    print("Chord notes: " + chord_notes.toString());
    //print("Pitch:");
    measure1 = Measure([
      const Clef(ClefType.treble),
      KeySignature(mv.getKeySignatureType(current_scale)),
      ChordNote([
        ChordNotePart(mv.getPitchByStringNeutral(chord_notes[0])),
        ChordNotePart(mv.getPitchByStringNeutral(chord_notes[1])),
        ChordNotePart(mv.getPitchByStringNeutral(chord_notes[2])),
      ]),
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
              measures: [measure1],
            );
  }
}