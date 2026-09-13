import 'package:chord_lang/model/ChordGenerator.dart';
import 'package:chord_lang/model/MidiValue.dart';
import 'package:chord_lang/model/Scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notemus/flutter_notemus.dart';
import 'package:provider/provider.dart';

class SimpleSheetMusicView extends StatelessWidget {
  const SimpleSheetMusicView({super.key});


  @override
  Widget build(BuildContext context) {
    

    return Consumer<ChordGenerator>(
      
      builder: (context, value, child) {
      
        MidiValue mv = MidiValue();

        List<String> chord_notes = value.getCurrentChords();
        String current_scale = value.getScale();
        Scale scale = Scale();

        //Measure measure1;

        print("Chord notes: " + chord_notes.toString());

        final staff = Staff();
        final measure = Measure();

        measure.add(Clef(clefType: ClefType.treble));
        measure.add(TimeSignature(numerator: 4, denominator: 4));
        /*measure.add(Note(
          pitch: const Pitch(step: 'C', octave: 5),
          duration: const Duration(DurationType.quarter),
        ));
        measure.add(Note(
          pitch: const Pitch(step: 'E', octave: 5),
          duration: const Duration(DurationType.quarter),
        ));
        measure.add(Note(
          pitch: const Pitch(step: 'G', octave: 5),
          duration: const Duration(DurationType.quarter),
        ));
        measure.add(Note(
          pitch: const Pitch(step: 'C', octave: 6),
          duration: const Duration(DurationType.quarter),
        ));*/

        measure.add(Chord(
          notes: [
                    Note(pitch: Pitch(step: value.getRootWithoutOctave(), octave: value.getOctaveOfRoot()), duration: const Duration(DurationType.whole)),
                    Note(pitch: Pitch(step: value.getThirdWithoutOctave(), octave: value.getOctaveOfThird()), duration: const Duration(DurationType.whole)),
                    Note(pitch: Pitch(step: value.getFifthWithoutOctave(), octave: value.getOctaveOfFifth()), duration: const Duration(DurationType.whole)),
                  ],
          duration: const Duration(DurationType.whole),
        ));

        staff.add(measure);

        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 200,
              height: 1000,
              child: MusicScore(staff: staff),
            ),
          ),
        );
            
      }
    );
  }
}