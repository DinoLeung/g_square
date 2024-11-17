import 'package:g_square/models/time_zone.dart';

class BytesConverter {
  static List<int> dateTimeToBytes(DateTime date) {
    List<int> bytes = [];

    // Year represented in two bytes
    bytes.add((date.year >> 8) & 0xFF); // Higher byte
    bytes.add(date.year & 0xFF); // Lower byte

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

  static List<int> stringToBytes(String str) => str.codeUnits;
  static String stringFromBytes(List<int> data) =>
      String.fromCharCodes(data.where((byte) => byte != 0));

  static List<int> clocksPairToBytes(
          int positionA, int positionB, Clock clockA, Clock clockB) =>
      [
        positionA,
        positionB,
        clockA.dstStatus.byte,
        clockB.dstStatus.byte,
        ...clockA.timeZone.data.identifierBytes,
        ...clockB.timeZone.data.identifierBytes
      ];

  // static List<int> timeZoneToBytes(TimeZone timeZone) => [
  //       ...timeZone.data.identifier,
  //       timeZone.data.offset,
  //       timeZone.data.dstOffset,
  //       timeZone.data.dstRules
  //     ];
  
  // 41 44 45 4c 41 49 44 45 00 00 00 00 00 00 00 00 00 00
}
