import 'package:chord_lang/model/MidiValue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// class responsible for giving certain notes and chords of a scale
class ChordGenerator extends ChangeNotifier{
  late String scale;
  static const List<int> major_half_steps = [2,2,1,2,2,2]; // last one should be 1 but it's the tonic
  static const List<int> minor_half_steps = [2,1,2,2,1,2]; // last one should be 2 but it's the tonic
  static const List<String> chord_qualities_major = ["Major","Minor","Minor","Major","Major","Minor","Diminisched"];
  static const List<String> chord_qualities_minor = ["Minor","Diminisched","Major","Minor","Minor","Major","Major"];
  late final List<String> major_scale_notes;
  late final List<String> minor_scale_notes;

  String tonic_midi_string = "";
  int tonic_midi_int = 0;

  List<String> current_chords = [];
  List<List<String>> major_chords_list = [];
  List<List<String>> minor_chords_list = [];

  bool major = false;

  // 0: nothing, -1: flat, 1: sharp 
  bool sharps = false;
  bool flats = false;
  bool nothing = false;

  bool root_is_set = false;
  bool third_is_set = false;
  bool fifth_is_set = false;
  
   ChordGenerator(String scale, bool hasSharps, bool hasFlats, bool hasNothing) {
    this.scale = scale;
    this.major_scale_notes = setMajorScaleNotesAsString();
    this.minor_scale_notes = setMinorScaleNotesAsString();
    
    if(! scale.trim().split("").contains('m')) {
      this.major = true;
      this.major_chords_list = getChordsFromMajorScale();
      this.current_chords = getChordsFromMajorScale().first;
    } else {
      this.minor_chords_list = getChordsFromMinorScale();
      this.current_chords = getChordsFromMinorScale().first;
    }

    this.sharps = hasSharps;
    this.flats = hasFlats;
    this.nothing = hasNothing;

    updateAccidentalSettings();

  }

  void updateAccidentalSettings() {
    if(current_chords[0].contains('/')) {
      this.root_is_set = true;
    } else {
      this.root_is_set = false;
    }

    if(current_chords[1].contains('/')) {
      print(current_chords[1]);
      this.third_is_set = true;
    } else {
      this.third_is_set = false;
    }

    if(current_chords[2].contains('/')) {
      this.fifth_is_set = true;
    } else {
      this.fifth_is_set = false;
    }
  }

  String getRootWithoutOctave(){
    //print(current_chords[0].split('')[0]);
    //return current_chords[0].split('')[0];

    if(current_chords[0].contains('/')) {
      //this.root_is_set = true;
      List<String> two_possible_notes = current_chords[0].split('/');
      String resulting_note = sharps ? two_possible_notes[0].replaceAll('#', '') : two_possible_notes[1].replaceAll('b', '');
      return resulting_note.split('')[0];
    }
    //this.root_is_set = false;
    return current_chords[0].split('')[0];
  }

  String getThirdWithoutOctave(){
    if(current_chords[1].contains('/')) {
      //this.third_is_set = true;
      List<String> two_possible_notes = current_chords[1].split('/');
      String resulting_note = sharps ? two_possible_notes[0].replaceAll('#', '') : two_possible_notes[1].replaceAll('b', '');
      return resulting_note.split('')[0];
    }

    //this.third_is_set = false;
    return current_chords[1].split('')[0];
  }

  String getFifthWithoutOctave(){
    if(current_chords[2].contains('/')) {
      //this.fifth_is_set = true;
      List<String> two_possible_notes = current_chords[2].split('/');
      String resulting_note = sharps ? two_possible_notes[0].replaceAll('#', '') : two_possible_notes[1].replaceAll('b', '');
      return resulting_note.split('')[0];
    }

    //this.fifth_is_set = false;
    return current_chords[2].split('')[0];
  }

  int getOctaveOfRoot(){
    //print(current_chords[0].split('')[1]);
    return int.parse(current_chords[0].replaceAll('#', '').replaceAll('m', '').replaceAll('b', '').split('')[1]);
  }

  int getOctaveOfThird(){
    print(current_chords[1].replaceAll('#', '').replaceAll('m', '').replaceAll('b', '').split('')[1]);
    return int.parse(current_chords[1].replaceAll('#', '').replaceAll('m', '').replaceAll('b', '').split('')[1]);
  }

  int getOctaveOfFifth(){
    return int.parse(current_chords[2].replaceAll('#', '').replaceAll('m', '').replaceAll('m', '').split('')[1]);
  }

  void setNewChords() {
    if (major) {

      if(this.major_chords_list.indexOf(this.current_chords) == this.major_chords_list.length - 1) {
        this.current_chords = this.major_chords_list.first;
        notifyListeners();
      } else {
        //int idx = this.major_chords_list.indexOf(current_chords);
        int idx = getIdxOfList(this.current_chords, this.major_chords_list);
        this.current_chords = this.major_chords_list.elementAt(idx + 1);
        notifyListeners();
      }

    } else {

        if(this.minor_chords_list.indexOf(this.current_chords) == this.minor_chords_list.length - 1) {
        this.current_chords = this.minor_chords_list.first;
        notifyListeners();
      } else {
        int idx = getIdxOfList(this.current_chords, this.minor_chords_list);
        this.current_chords = this.minor_chords_list.elementAt(idx + 1);
        notifyListeners();
      }

    }

    updateAccidentalSettings();

    notifyListeners();
  }

  int getIdxOfList(List<String> l, List<List<String>> cl) {
    int idx = 0;
    int result = 0;
    for (List<String> e in cl) {
      if(setEquals(l.toSet(),e.toSet())) {
        result = idx;
      }
      idx++;
    }

    return result;
  }

  String getScale() {
    return this.scale;
  }

  List<String> getCurrentChords() {
    return this.current_chords;
  }
  
  /*String getTonicAsMidiString() {
    String result = tonic_midi_string;
    MidiValue mv = MidiValue();

    while(!this.tonic_midi_string.contains('4')){
      this.tonic_midi_int= this.tonic_midi_int + 12;
      this.tonic_midi_string = mv.getNoteStringFromMidiValue(this.tonic_midi_int);

      result = tonic_midi_string;
    }
    return result;
  }*/

  /*int getTonicAsMidiValue() {
    MidiValue mv = MidiValue();
    return mv.getNoteMidiValue(getTonicAsMidiString());
  }*/

  List<String> setMajorScaleNotesAsString() {
    MidiValue mv = MidiValue();

    List<String> result = [];
    this.tonic_midi_int = mv.getNoteMidiValue(this.scale + '4');
    this.tonic_midi_string = mv.getNoteStringFromMidiValue(this.tonic_midi_int.toString());
    
    int current_distance = this.tonic_midi_int;

    result.add(tonic_midi_string);

    for (int step in major_half_steps) {
      current_distance += step;
      result.add(mv.getNoteStringFromMidiValue(current_distance.toString())!);
    }

    return result;
  }

  List<String> setMinorScaleNotesAsString() {
    MidiValue mv = MidiValue();

    List<String> result = [];
    this.tonic_midi_int = mv.getNoteMidiValue(this.scale + '4');
    this.tonic_midi_string = mv.getNoteStringFromMidiValue(this.tonic_midi_int.toString());

    int current_distance = this.tonic_midi_int;
    result.add(tonic_midi_string);

    for (int step in minor_half_steps) {
      current_distance += step;
      result.add(mv.getNoteStringFromMidiValue(current_distance.toString())!);
    }

    return result;
  }

  List<String> getMajorScaleNotesAsStringList() => this.major_scale_notes;
  List<String> getMinorScaleNotesAsStringList() => this.minor_scale_notes;

  List<List<String>> getChordsFromMajorScale() {
    List<List<String>> result = [];

    int note_counter = 0;
    for (String quality in chord_qualities_major) {
      result.add(getSingleChordList(major_scale_notes[note_counter], quality));
      note_counter++;
    }

    return result;
  }

  List<List<String>> getChordsFromMinorScale() {
    List<List<String>> result = [];

    int note_counter = 0;
    for (String quality in chord_qualities_minor) {
      //print(quality);
      result.add(getSingleChordList(minor_scale_notes[note_counter], quality));
      note_counter++;
    }

    return result;
  }

  List<String> getSingleChordList(String root, String quality) {
    List<String> result = [];
    MidiValue mv = MidiValue();
    int root_midi_value = mv.getNoteMidiValue(root);

    // 1
    result.add(root);

    int tmp_result;
    // 2
    if(quality == "Major" || quality == "Augmented") {
      tmp_result = root_midi_value + 4;
      result.add(mv.getNoteStringFromMidiValue(tmp_result.toString()));
    } else {
      tmp_result = root_midi_value + 3;
      result.add(mv.getNoteStringFromMidiValue(tmp_result.toString()));
    }

    // 3
    if(quality == "Major" || quality == "Diminisched") {
      tmp_result = tmp_result + 3;
      result.add(mv.getNoteStringFromMidiValue(tmp_result.toString()));
    } else {
      tmp_result = tmp_result + 4;
      result.add(mv.getNoteStringFromMidiValue(tmp_result.toString()));
    }

    return result;
  }
}