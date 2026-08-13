import 'dart:js_interop';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:chord_lang/PracticeView.dart';
import 'package:chord_lang/model/Scale.dart';
import 'package:chord_lang/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
//import 'package:flutter_midi_command/flutter_midi_command_messages.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void connectToMidiDevice() async {
    final midi = MidiCommand();

    final device = (await midi.devices)!.first;

    await midi.connectToDevice(
      device,
      awaitConnectionTimeout: const Duration(seconds: 10),
    );
    
    /*
    midi.sendData(
      NoteOnMessage(channel: 0, note: 60, velocity: 100).generateData(),
      deviceId: device.id,
    );
    */
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //connectToMidiDevice();
    
    return MaterialApp(
      title: 'Chord Lang',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _dropdownValue = 'C';
  bool _major = true;

  @override
  Widget build(BuildContext context) {
    //const dp = DropdownButtonExample();
    Scale scale = Scale();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            const Text('Select a scale:'),

            DropdownButton<String>(
              value: _dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(height: 2, color: Colors.deepPurpleAccent),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  _dropdownValue = value!;
                });
              },
              items: scale.getAllScalesAsStringList().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
            ),
            
            FlutterSwitch(
                  activeText: "major",
                  inactiveText: "minor",
                  value: _major,
                  valueFontSize: 10.0,
                  width: 80,
                  height: 30,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      _major = val;
                    });
                  },
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Practiceview(_dropdownValue, _major))); // Source - https://stackoverflow.com/a/54165550 Posted by Suragch, modified by community. See post 'Timeline' for change history Rerieved 2026-07-30, License - CC BY-SA 4.0
              },

              child: Text('Start Practice Session'),
            )
          ],
        ),
      ),
    );
  }
}