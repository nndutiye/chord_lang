import 'package:chord_lang/model/MidiValue.dart';

class ChordGenerator {
  final String scale;
  const ChordGenerator(this.scale);
  
  String getTonicAsMidiString() {
    return this.scale + '3';
  }

  int getTonicAsMidiValue() {
    MidiValue mv = MidiValue();
    return mv.getNoteMidiValue(getTonicAsMidiString());
  }
}