import 'dart:async';

import 'package:chord_lang/SimpleSheetMusicView.dart';
import 'package:chord_lang/model/ChordGenerator.dart';
import 'package:chord_lang/model/MidiValue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

class Practiceview extends StatefulWidget {
  const Practiceview(this.scale_selection, {super.key});
  
  final scale_selection;
  @override
  State<Practiceview> createState() => _PracticeviewState(scale_selection);
}

class _PracticeviewState extends State<Practiceview> {
  _PracticeviewState(String scale_selection) {
    this._scale_selection = scale_selection;
  }
  
  String _scale_selection = "";
  List<String> _current_chords = [];

  Future<StreamSubscription<MidiDataReceivedEvent>> connectToMidiDevice(String _scale_selection) async {
    final midi = MidiCommand();

    final device = (await midi.devices)!.first;

    await midi.connectToDevice(
      device,
      awaitConnectionTimeout: const Duration(seconds: 1),
    );
    
    if (device.connected) {
      print("conneced!");
    }

    Set<String> testChord = {"C3", "E3", "G3"};
    // This is the centerpiece of the whole application
    List<String> noteCharList = [];
    List<String> chordNameList = []; // has to be generated

    final sub_init = midi.onMidiDataReceived!.listen(
      (data) {
        MidiMessage midiMessage = data.message;
        String noteInput = midiMessage.data[1].toString();

        MidiValue mv = MidiValue();
        String noteChar = mv.getNoteStringFromMidiValue(noteInput);

        if((midiMessage is! NoteOnMessage)) {
          noteCharList.remove(noteChar);
        }

        if(midiMessage is NoteOnMessage) {
          noteCharList.add(noteChar);
        }

        print(noteCharList);

        if(setEquals(testChord, noteCharList.toSet())){
          print("played correct note");
        }
      },
    );

    noteCharList.clear();

    return sub_init;
  }

  void cancelSubscription(Future<StreamSubscription<MidiDataReceivedEvent>> s) async {
    StreamSubscription<MidiDataReceivedEvent> sub = await s;
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ChordGenerator cg = ChordGenerator(_scale_selection);

    if(! _scale_selection.trim().split("").contains('m')) {
      _current_chords = cg.getChordsFromMajorScale().first;
    } else {
      _current_chords = cg.getChordsFromMinorScale().first;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Practice Session')),
      body: Center( 
        child: 
          SimpleSheetMusicView(_current_chords, _scale_selection),
      ),
    );
  }
}