import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

class Practiceview extends StatelessWidget {
  const Practiceview({super.key});

  void connectToMidiDevice() async {
    final midi = MidiCommand();
    final received = <MidiDataReceivedEvent>[];

    final device = (await midi.devices)!.first;

    await midi.connectToDevice(
      device,
      awaitConnectionTimeout: const Duration(seconds: 1),
    );
    

    
    final sub = midi.onMidiDataReceived!.listen(
      (data) {
        String s = data.message.data[1].toString();
        //String t = data.toString();
        print('U8intlist: $s');
        //print('Just data: $t');
      }
    );
      
    //print("The data is: " + received.first.message.data.toString());
    await Future<void>.delayed(const Duration(seconds: 1000));

    sub.cancel();
  }

    
  
  @override
  Widget build(BuildContext context) {
    connectToMidiDevice();
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Session')),
    );
  }
}