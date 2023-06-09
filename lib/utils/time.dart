String formatDuration(int minutes) {
  int d = minutes;
  int h = d ~/ 60; // calculate hours
  d %= 60; // calculate remaining minutes
  if (h == 0) {
    return "${d}m";
  } else {
    return "${h}h${d}m";
  }
}
