import 'package:chord_lang/model/MidiValue.dart';

class ChordGenerator {
  final String scale;
  static const List<int> major_half_steps = [2,2,1,2,2,2,1];
  static const List<int> minor_half_steps = [2,1,2,2,1,2,2];

  const ChordGenerator(this.scale);
  
  String getTonicAsMidiString() {
    return this.scale + '3';
  }

  int getTonicAsMidiValue() {
    MidiValue mv = MidiValue();
    return mv.getNoteMidiValue(getTonicAsMidiString());
  }
}