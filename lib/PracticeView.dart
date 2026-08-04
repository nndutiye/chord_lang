import 'dart:async';
import 'dart:js_interop';

import 'package:chord_lang/main.dart';
import 'package:chord_lang/model/MidiValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

class Practiceview extends StatelessWidget {
  const Practiceview({super.key});
  

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

    // This is the centerpiece of the whole application
    List<String> noteCharList = [];
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

      },
    );


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
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Session')),
      body: OutlinedButton(
              onPressed: () {
                cancelSubscription(sub);


                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp())); // Source - https://stackoverflow.com/a/54165550 Posted by Suragch, modified by community. See post 'Timeline' for change history Rerieved 2026-07-30, License - CC BY-SA 4.0

              },

              child: Text('End Practice Session'),
            ),
    );
  }
}