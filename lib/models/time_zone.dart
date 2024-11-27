import 'package:g_square/constants/home_time_zones.dart';
import 'package:g_square/constants/world_time_zones.dart';
import 'package:g_square/utils/bytes_converter.dart';

abstract class TimeZone {
  final String cityName;
  final int identifier;
  final double offset;
  final double dstDiff;
  final int dstRules;

  const TimeZone({
    required this.cityName,
    required this.identifier,
    required this.offset,
    required this.dstDiff,
    required this.dstRules,
  });

  List<int> get identifierBytes => BytesConverter.intTo2Bytes(identifier);

  List<int> get bytes =>
      [...identifierBytes, offsetByte, dstOffsetByte, dstRules];

  // city name in 18 bytes
  List<int> get cityNameBytes {
    var bytes = List<int>.filled(18, 0x00);
    bytes.setRange(0, cityName.length, cityName.codeUnits);
    return bytes;
  }

  // offsets are in 15 minutes intervals
  int get offsetByte => (offset * 4).toInt();
  int get dstOffsetByte => (dstDiff * 4).toInt();
}

class HomeTimeZone extends TimeZone {
  final String timeZone;

  const HomeTimeZone({
    required super.cityName,
    required super.identifier,
    required super.offset,
    required super.dstDiff,
    required super.dstRules,
    required this.timeZone,
  });

  static List<HomeTimeZone> fuzzySearch(String keyword) {
    var keywordLowerCase = keyword.trim().toLowerCase();
    if (keywordLowerCase.isEmpty) return homeTimeZones.values.toList();
    return homeTimeZones.values
        .where((tz) => tz.timeZone.toLowerCase().contains(keywordLowerCase))
        .toList();
  }
}

class WorldTimeZone extends TimeZone {
  final String country;
  final String city;

  const WorldTimeZone(
      {required super.cityName,
      required super.identifier,
      required super.offset,
      required super.dstDiff,
      required super.dstRules,
      required this.country,
      required this.city});

  static List<WorldTimeZone> fuzzySearch(String keyword) {
    var keywordLowerCase = keyword.trim().toLowerCase();
    if (keywordLowerCase.isEmpty) return worldTimeZones.values.toList();
    return worldTimeZones.values
        .where((tz) =>
            tz.country.toLowerCase().contains(keywordLowerCase) ||
            tz.city.toLowerCase().contains(keywordLowerCase))
        .toList();
  }
}
