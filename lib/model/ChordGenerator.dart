import 'package:chord_lang/model/MidiValue.dart';

// class responsible for giving certain notes and chords of a scale
class ChordGenerator {
  late String scale;
  static const List<int> major_half_steps = [2,2,1,2,2,2]; // last one should be 1 but it's the tonic
  static const List<int> minor_half_steps = [2,1,2,2,1,2]; // last one should be 2 but it's the tonic
  static const List<String> chord_qualities_major = ["Major","Minor","Minor","Major","Major","Minor","Diminisched"];
  static const List<String> chord_qualities_minor = ["Minor","Diminisched","Major","Minor","Minor","Major","Major"];
  late final List<String> major_scale_notes;
  late final List<String> minor_scale_notes;

  
   ChordGenerator(String scale) {
    this.scale = scale;
    this.major_scale_notes = setMajorScaleNotesAsString();
    this.minor_scale_notes = setMinorScaleNotesAsString();
  }
  
  String getTonicAsMidiString() {
    return '${this.scale}4';
  }

  int getTonicAsMidiValue() {
    MidiValue mv = MidiValue();
    return mv.getNoteMidiValue(getTonicAsMidiString());
  }

  List<String> setMajorScaleNotesAsString() {
    MidiValue mv = MidiValue();

    List<String> result = [];
    int current_distance = getTonicAsMidiValue();

    result.add(getTonicAsMidiString());

    for (int step in major_half_steps) {
      current_distance += step;
      result.add(mv.getNoteStringFromMidiValue(current_distance.toString())!);
    }

    return result;
  }

  List<String> setMinorScaleNotesAsString() {
    MidiValue mv = MidiValue();

    List<String> result = [];
    int current_distance = getTonicAsMidiValue();

    result.add(getTonicAsMidiString());

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
      print(quality);
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