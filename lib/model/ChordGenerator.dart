class ChordGenerator {
  final String scale;
  const ChordGenerator(this.scale);
  
  String getTonicAsMidi() {
    return scale + '3';
  }
}