class Scale {
  //List<String> scales = ['C', 'G', 'F', 'D', 'A', 'E', 'B',];
  List<String> scales = ['C', 'G', 'F', 'D', 'Bb', 'A', 'Eb', 'E', 'Ab', 'Em', 'Bm', 'F#m', 'C#m', 'Dm', 'Gm', 'Cm', 'Fm', 'Am'];
  //List<String> scales = ['C', 'G', 'F', 'D', 'Bb', 'A', 'Eb', 'E', 'Ab', 'B', 'Cb', 'Db', 'C#', 'Gb', 'F#'];
  List<String> neutral = ['C', 'Am'];
  List<String> sharps = ['G', 'Em', 'D', 'Bm', 'A', 'F#m', 'E', 'C#m'];
  List<String> flats = ['F', 'Dm', 'Bb', 'Gm', 'Eb', 'Cm', 'Ab', 'Fm'];
  List<String> getAllScalesAsStringList() => this.scales;

  bool hasSharps(String scale_name) {
    return sharps.contains(scale_name);
  }
}
