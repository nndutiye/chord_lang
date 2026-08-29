import 'dart:async';

import 'package:chord_lang/SimpleSheetMusicView.dart';
import 'package:chord_lang/main.dart';
import 'package:chord_lang/model/ChordGenerator.dart';
import 'package:chord_lang/model/MidiValue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

class Practiceview extends StatefulWidget {
  const Practiceview(this.scale_selection, this.major, {super.key});
  
  final scale_selection;
  final bool major;
  @override
  State<Practiceview> createState() => _PracticeviewState(scale_selection, major);
}

class _PracticeviewState extends State<Practiceview> {
  _PracticeviewState(String scale_selection, bool major) {
    this._scale_selection = scale_selection;
    this._major = major;
  }
  bool _major = true;
  String _scale_selection = "";
  //bool _played_correct_chord = false;
  String _chord_image_name = 'assets/images/Am.png';
  List<String> _current_chords = [];

  void _newChord(String s) {
    setState(() {
      _chord_image_name = s;
    });
  }

  void generateChords(String s){
    ChordGenerator cg = ChordGenerator(s);
    print(cg.getTonicAsMidiString());
    print(cg.getTonicAsMidiValue().toString());
    //print(cg.getMajorScaleNotesAsString());
  }
  Future<StreamSubscription<MidiDataReceivedEvent>> connectToMidiDevice(String _scale_selection) async {
    //generateChords(_scale_selection);
    final midi = MidiCommand();
    
    //final received = <MidiDataReceivedEvent>[];

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
        //print('U8intlist: $s');

        MidiValue mv = MidiValue();
        String noteChar = mv.getNoteStringFromMidiValue(noteInput)!;

        //print('Note Char: $noteChar');

        if((midiMessage is! NoteOnMessage)) {
          noteCharList.remove(noteChar);
        }

        if(midiMessage is NoteOnMessage) {
          noteCharList.add(noteChar);
        }

        print(noteCharList);

        if(setEquals(testChord, noteCharList.toSet())){
          print("played correct note");
          _newChord('assets/images/B°.png');
        }
      },
    );

    noteCharList.clear();

    return sub_init;

    //await Future<void>.delayed(const Duration(seconds: 1000));
    //print("cancel");
    //sub.cancel();
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
    //print(_current_chords);
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Session')),
      body: Center( 
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        child: 
          SimpleSheetMusicView(_current_chords, _scale_selection),
      ),
    );
  }
}