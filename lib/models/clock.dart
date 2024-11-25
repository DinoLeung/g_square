import 'package:g_square/models/time_zone.dart';
import 'package:g_square/resources/home_time_zones.dart';
import 'package:g_square/resources/world_time_zones.dart';

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

abstract class Clock {
  TimeZone timeZone;
  DstStatus dstStatus;

  Clock({required this.timeZone, required this.dstStatus});
}

class HomeClock extends Clock {

  HomeClock({required super.timeZone, required super.dstStatus});

  static HomeClock fromTimeZoneId(int timeZoneId, DstStatus dstStatus) {
    if (homeTimeZones.containsKey(timeZoneId) == false) {
      throw ClockError('Home time zone ID $timeZoneId does not exist.');
    }
    return HomeClock(timeZone: homeTimeZones[timeZoneId]!, dstStatus: dstStatus);
  }

  @override
  HomeTimeZone get timeZone => super.timeZone as HomeTimeZone;
}

class WorldClock extends Clock {

  WorldClock({required super.timeZone, required super.dstStatus});

  static WorldClock fromTimeZoneId(int timeZoneId, DstStatus dstStatus) {
    if (worldTimeZones.containsKey(timeZoneId) == false) {
      throw ClockError('Home time zone ID $timeZoneId does not exist.');
    }
    return WorldClock(timeZone: worldTimeZones[timeZoneId]!, dstStatus: dstStatus);
  }

  @override
  WorldTimeZone get timeZone => super.timeZone as WorldTimeZone;
}

class ClockError implements Exception {
  final String message;

  ClockError(this.message);

  @override
  String toString() => 'ClockError: $message';
}
