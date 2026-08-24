import 'package:chord_lang/model/MidiValue.dart';

// class responsible for giving certain notes and chords of a scale
class ChordGenerator {
  final String scale;
  static const List<int> major_half_steps = [2,2,1,2,2,2]; // last one should be 1 but it's the tonic
  static const List<int> minor_half_steps = [2,1,2,2,1,2]; // last one should be 2 but it's the tonic

  const ChordGenerator(this.scale);
  
  String getTonicAsMidiString() {
    return '${this.scale}3';
  }

  int getTonicAsMidiValue() {
    MidiValue mv = MidiValue();
    return mv.getNoteMidiValue(getTonicAsMidiString());
  }

  List<String> getMajorScaleNotesAsString() {
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

  List<String> getMinorScaleNotesAsString() {
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
}