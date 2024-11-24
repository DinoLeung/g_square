import 'package:g_square/utils/bytes_converter.dart';

class TimeZone {
  final String cityName;
  final int identifier;
  final int offset;
  final int dstOffset;
  final int dstRules;

  const TimeZone({
    required this.cityName,
    required this.identifier,
    required this.offset,
    required this.dstOffset,
    required this.dstRules,
  });

  static TimeZone fromIdentifier(int identifier) {
    // TODO: find from CSVs then return TimeZone object
    if (identifier < 30000) {
      // World time
    } else {
      // Home time
    }

    return TimeZone(
        cityName: "UTC", identifier: 0, offset: 0, dstOffset: 0, dstRules: 0);
  }

  bool get isHomeTime => identifier >= 30000;
  bool get isworldTime => identifier < 30000;
  List<int> get identifierBytes => BytesConverter.intTo2Bytes(identifier);

  List<int> get bytes => [...identifierBytes, offset, dstOffset, dstRules];

  // city name in 18 bytes
  List<int> get cityNameBytes {
    var bytes = List<int>.filled(18, 0x00);
    bytes.setRange(0, cityName.length, cityName.codeUnits);
    return bytes;
  }
}

// TODO: MANY time zones from the app are not on this list.
// Go through the decompiled casio app to figure out all of them
// enum TimeZone {

//   final TimeZoneData data;

//   const TimeZone(this.data);

// // TODO: error handling
//   static TimeZone fromCityName(String cityName) =>
//       TimeZone.values.firstWhere((tz) => tz.data.cityName == cityName);
// // TODO: error handling
//   static TimeZone fromIdentifiers(int identifierA, int identifierB) =>
//       TimeZone.values.firstWhere((tz) =>
//           tz.data.identifierA == identifierA &&
//           tz.data.identifierB == identifierB);
// }

enum DstStatus {
  // 00000000
  manualOff(0),
  // 00000001
  manualOn(1),
  // 00000010
  autoOff(2),
  // 00000011
  autoOn(3);

  final int byte;

  const DstStatus(this.byte);

  static DstStatus fromByte(int byte) =>
      DstStatus.values.firstWhere((v) => v.byte == byte);
}

class Clock {
  TimeZone timeZone;
  DstStatus dstStatus;

  Clock(this.dstStatus, this.timeZone);
}
