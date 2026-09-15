class Scale {
  List<String> scales = ['C', 'G', 'F', 'D', 'Bb', 'A', 'Eb', 'E', 'Ab', 'Em', 'Bm', 'F#m', 'C#m', 'Dm', 'Gm', 'Cm', 'Fm', 'Am'];
  List<String> neutral = ['C', 'Am'];
  List<String> sharps = ['G', 'Em', 'D', 'Bm', 'A', 'F#m', 'E', 'C#m'];
  List<String> flats = ['F', 'Dm', 'Bb', 'Gm', 'Eb', 'Cm', 'Ab', 'Fm'];
  List<String> getAllScalesAsStringList() => this.scales;

  bool hasSharps(String scale_name) {
    return sharps.contains(scale_name);
  }

  int countOfAccidentals(String scale_name) {
    switch(scale_name) {
      case 'C':
        return 0;
      case 'G':
        return 1; 
      case 'F':
        return -1;
      case 'D':
        return 2;
      case 'A':
        return 3;
      case 'E':
        return 4;
      case 'Bb':
        return -2;
      case 'Eb':
        return -3;
      case 'Ab':
        return -4;
      case 'F#':
        return 3;
      case 'Em':
        return 1;
      case 'Bm':
        return 2;
      case 'F#m':
        return 3;
      case 'C#m':
        return 4;
      case 'Dm':
        return -1;
      case 'Gm':
        return -2;
      case 'Cm':
        return -3;
      case 'Fm':
        return -4;
      case 'Am':
        return 0;
      default:
        return 0;
    }
  }
}
