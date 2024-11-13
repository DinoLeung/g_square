class TimeEncoder {
  static List<int> dateTimetoBytes(DateTime date) {
    List<int> bytes = [];

    // Year represented in two bytes
    bytes.add((date.year >> 8) & 0xFF); // Higher byte
    bytes.add(date.year & 0xFF);         // Lower byte

    // Month and Day as single bytes
    bytes.add(date.month);
    bytes.add(date.day);

    // Hour, Minute, and Second as single bytes
    bytes.add(date.hour);
    bytes.add(date.minute);
    bytes.add(date.second);

    // Weekday (Monday = 1, ..., Sunday = 7)
    bytes.add(date.weekday);

    // Milliseconds, scaled to 0-255 for 1 byte (if needed)
    bytes.add((date.millisecond * 255 / 999).round());

    return bytes;
  }
}
