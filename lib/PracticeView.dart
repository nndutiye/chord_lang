import 'dart:async';
import 'dart:js_interop';

import 'package:chord_lang/main.dart';
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
  bool _played_correct_chord = false;
  String _chord_image_name = 'assets/images/Am.png';

  void _newChord(String s) {
    setState(() {
      _chord_image_name = s;
    });
  }

  Future<StreamSubscription<MidiDataReceivedEvent>> connectToMidiDevice() async {
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
    Future<StreamSubscription<MidiDataReceivedEvent>> sub = connectToMidiDevice();
    //cancelSubscription(sub);
    print(_scale_selection);
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Session')),
      body: Column( 
        children: [
          Image.asset(
            _chord_image_name,
            width: 600,
            height: 500,
          ),
          Spacer(flex: 1),
          Center(
            child: OutlinedButton(
                  onPressed: () {
                    cancelSubscription(sub);


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp())); // Source - https://stackoverflow.com/a/54165550 Posted by Suragch, modified by community. See post 'Timeline' for change history Rerieved 2026-07-30, License - CC BY-SA 4.0

                  },

                  child: Text('End Practice Session'),
          ),
          ),
        ]
    ),
    );
  }
}