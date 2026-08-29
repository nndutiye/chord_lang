import 'package:chord_lang/model/MidiValue.dart';
import 'package:chord_lang/model/Scale.dart';
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
    Scale scale = Scale();
    
    print("Chord notes: " + chord_notes.toString());
    Pitch root_note = chord_notes[0].trim().split("").contains('/') ?
                      mv.getPitchByStringTwoPossibilities(chord_notes[0], scale.hasSharps(current_scale) ? "down" : "up") :
                      mv.getPitchByStringNeutral(chord_notes[0]);

    Pitch second_note = chord_notes[1].trim().split("").contains('/') ?
                      mv.getPitchByStringTwoPossibilities(chord_notes[1], scale.hasSharps(current_scale) ? "down" : "up") :
                      mv.getPitchByStringNeutral(chord_notes[1]);
    Pitch third_note = chord_notes[2].trim().split("").contains('/') ?
                      mv.getPitchByStringTwoPossibilities(chord_notes[2], scale.hasSharps(current_scale) ? "down" : "up") :
                      mv.getPitchByStringNeutral(chord_notes[2]);                
    measure1 = Measure([
      const Clef(ClefType.treble),
      KeySignature(mv.getKeySignatureType(current_scale)),
      ChordNote([
        ChordNotePart(root_note),
        ChordNotePart(second_note),
        ChordNotePart(third_note),
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