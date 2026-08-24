import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

class SimpleSheetMusicView extends StatefulWidget {
  const SimpleSheetMusicView({super.key});

  @override
  State<StatefulWidget> createState() => SimpleSheetMusicViewState();
}

class SimpleSheetMusicViewState extends State {
  late final Measure measure1;
  late final Measure measure2;
  late final Measure measure3;

  @override
  void initState() {
    measure1 = Measure([
      const Clef(ClefType.treble),
      const KeySignature(KeySignatureType.dMajor),
      const ChordNote([
        ChordNotePart(Pitch.b4),
        ChordNotePart(Pitch.g5, accidental: Accidental.sharp),
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
    measure3 = Measure(
      [
        const Clef(ClefType.bass),
        const KeySignature(KeySignatureType.cMinor),
        const ChordNote(
          [
            ChordNotePart(Pitch.c2),
            ChordNotePart(Pitch.c3),
          ],
        ),
        const Rest(RestType.quarter),
        const Note(Pitch.a3,
            noteDuration: NoteDuration.whole, accidental: Accidental.flat),
      ],
      isNewLine: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sheetMusicSize = MediaQuery.of(context).size;
    final width = sheetMusicSize.width;
    final height = sheetMusicSize.height / 2;
    return Scaffold(
        appBar: AppBar(title: const Text('Simple Sheet Music')),
        body: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SimpleSheetMusic(
              height: height,
              width: width,
              measures: [measure1, measure2, measure3],
            ),
          ),
        ));
  }
}