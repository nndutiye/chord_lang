import 'dart:ui';

import 'package:simple_sheet_music/simple_sheet_music.dart';

class MidiValue {
  Map<String,String> midiValueMap = {
    '21' : 'A0',
    '22' : 'A#0/Bb0',
    '23' : 'B0',

    '24' : 'C1',
    '25' : 'C#1/Db1',
    '26' : 'D1',
    '27' : 'D#1/Eb1',
    '28' : 'E1',
    '29' : 'F1',
    '30' : 'F#1/Gb1',
    '31' : 'G1',
    '32' : 'G#1/Ab1',
    '33' : 'A1',
    '34' : 'A#1/Bb1',
    '35' : 'B1',

    '36' : 'C2',
    '37' : 'C#2/Db2',
    '38' : 'D2',
    '39' : 'D#2/Eb2',
    '40' : 'E2',
    '41' : 'F2',
    '42' : 'F#2/Gb2',
    '43' : 'G2',
    '44' : 'G#2/Ab2',
    '45' : 'A2',
    '46' : 'A#2/Bb2',
    '47' : 'B2',

    '48' : 'C3',
    '49' : 'C#3/Db3',
    '50' : 'D3',
    '51' : 'D#3/Eb3',
    '52' : 'E3',
    '53' : 'F3',
    '54' : 'F#3/Gb3',
    '55' : 'G3',
    '56' : 'G#3/Ab3',
    '57' : 'A3',
    '58' : 'A#3/Bb3',
    '59' : 'B3',

    '60' : 'C4',
    '61' : 'C#4/Db4',
    '62' : 'D4',
    '63' : 'D#4/Eb4',
    '64' : 'E4',
    '65' : 'F4',
    '66' : 'F#4/Gb4',
    '67' : 'G4',
    '68' : 'G#4/Ab4',
    '69' : 'A4',
    '70' : 'A#4/Bb4',
    '71' : 'B4',

    '72' : 'C5',
    '73' : 'C#5/Db5',
    '74' : 'D5',
    '75' : 'D#5/Eb5',
    '76' : 'E5',
    '77' : 'F5',
    '78' : 'F#5/Gb5',
    '79' : 'G5',
    '80' : 'G#5/Ab5',
    '81' : 'A5',
    '82' : 'A#5/Bb5',
    '83' : 'B5',

    '84' : 'C6',
    '85' : 'C#6/Db6',
    '86' : 'D6',
    '87' : 'D#6/Eb6',
    '88' : 'E6',
    '89' : 'F6',
    '90' : 'F#6/Gb6',
    '91' : 'G6',
    '92' : 'G#6/Ab6',
    '93' : 'A6',
    '94' : 'A#6/Bb6',
    '95' : 'B6',

    '96' : 'C7',
    '97' : 'C#7/Db7',
    '98' : 'D7',
    '99' : 'D#7/Eb7',
    '100' : 'E7',
    '101' : 'F7',
    '102' : 'F#7/Gb7',
    '103' : 'G7',
    '104' : 'G#7/Ab7',
    '105' : 'A7',
    '106' : 'A#7/Bb7',
    '107' : 'B7',
    
    '108': 'C8',
  };
  
  Map<String,Pitch> stringPitchMapNeutral = {
    'A0': Pitch.a0,
    'B0': Pitch.b0,

    'C1': Pitch.c1,
    'D1': Pitch.d1,
    'E1': Pitch.e1,
    'F1': Pitch.f1,
    'G1': Pitch.g1,
    'A1': Pitch.a1,
    'B1': Pitch.b1,

    'C2': Pitch.c2,
    'D2': Pitch.d2,
    'E2': Pitch.e2,
    'F2': Pitch.f2,
    'G2': Pitch.g2,
    'A2': Pitch.a2,
    'B2': Pitch.b2,

    'C3': Pitch.c3,
    'D3': Pitch.d3,
    'E3': Pitch.e3,
    'F3': Pitch.f3,
    'G3': Pitch.g3,
    'A3': Pitch.a3,
    'B3': Pitch.b3,

    'C4': Pitch.c4,
    'D4': Pitch.d4,
    'E4': Pitch.e4,
    'F4': Pitch.f4,
    'G4': Pitch.g4,
    'A4': Pitch.a4,
    'B4': Pitch.b4,

    'C5': Pitch.c5,
    'D5': Pitch.d5,
    'E5': Pitch.e5,
    'F5': Pitch.f5,
    'G5': Pitch.g5,
    'A5': Pitch.a5,
    'B5': Pitch.b5,

    'C6': Pitch.c6,
    'D6': Pitch.d6,
    'E6': Pitch.e6,
    'F6': Pitch.f6,
    'G6': Pitch.g6,
    'A6': Pitch.a6,
    'B6': Pitch.b6,

    'C7': Pitch.c7,
    'D7': Pitch.d7,
    'E7': Pitch.e7,
    'F7': Pitch.f7,
    'G7': Pitch.g7,
    'A7': Pitch.a7,
    'B7': Pitch.b7,
    
    'C8': Pitch.c8,
  };

  Map<String,KeySignatureType> keySignatureMap = {
    'C': KeySignatureType.cMajor,
    'G': KeySignatureType.gMajor, 
    'F': KeySignatureType.fMajor, 
    'D': KeySignatureType.dMajor, 
    'A': KeySignatureType.aMajor, 
    'E': KeySignatureType.eMajor, 
    'B': KeySignatureType.bMajor,
  };

  String getNoteStringFromMidiValue(String s) {
    return midiValueMap[s]!;
  }

  int getNoteMidiValue(String s) {
    //print("input: " + s);
    var midi_key = midiValueMap.keys.firstWhere((k) => midiValueMap[k] == s);
    return int.parse(midi_key);
  }

  Pitch getPitchByStringNeutral(String s) {
    return stringPitchMapNeutral[s]!;
  }

  KeySignatureType getKeySignatureType(String s) => keySignatureMap[s]!;
}