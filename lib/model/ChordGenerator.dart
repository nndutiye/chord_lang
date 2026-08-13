class ChordGenerator {
  final String scale;
  const ChordGenerator(this.scale);
  
  String getTonicAsMidiString() {
    return scale + '3';
  }
}