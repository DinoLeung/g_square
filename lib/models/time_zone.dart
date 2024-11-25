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

  // static TimeZone fromIdentifier(int identifier);

  List<int> get identifierBytes => BytesConverter.intTo2Bytes(identifier);

  List<int> get bytes => [...identifierBytes, offsetByte, dstOffsetByte, dstRules];

  // city name in 18 bytes
  List<int> get cityNameBytes {
    var bytes = List<int>.filled(18, 0x00);
    bytes.setRange(0, cityName.length, cityName.codeUnits);
    return bytes;
  }

  // TODO: figure out how does the app represent negative offsets
  // e.g. Washington DC is -5 hours
  // offsets are in 15 minutes intervals
  int get offsetByte => (offset * 4).toInt();
  int get dstOffsetByte => ((offset + dstDiff) * 4).toInt();
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
}

class WorldTimeZone extends TimeZone {
  final String country;
  final String city;

  const WorldTimeZone({
    required super.cityName,
    required super.identifier,
    required super.offset,
    required super.dstDiff,
    required super.dstRules,
    required this.country,
    required this.city
  });
}
