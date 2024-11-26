import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import 'package:g_square/models/time_zone.dart';
import 'package:g_square/constants/home_time_zones.dart';
import 'package:g_square/constants/world_time_zones.dart';

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
  final TimeZone timeZone;
  final DstStatus dstStatus;

  Clock({required this.timeZone, required this.dstStatus});
}

class HomeClock extends Clock {
  final HomeTimeZone _timeZone;

  HomeClock(this._timeZone, DstStatus dstStatus)
      : super(timeZone: _timeZone, dstStatus: dstStatus);

  static HomeClock fromTimeZoneId(int timeZoneId, DstStatus dstStatus) {
    if (homeTimeZones.containsKey(timeZoneId) == false) {
      throw ClockError('Home time zone ID $timeZoneId does not exist.');
    }
    return HomeClock(homeTimeZones[timeZoneId]!, dstStatus);
  }

  Future<tz.TZDateTime> getCurrentDateTime() async {
    tz_data.initializeTimeZones();
    tz.Location detroit = tz.getLocation(_timeZone.timeZone);
    return tz.TZDateTime.now(detroit);
  }

  @override
  HomeTimeZone get timeZone => _timeZone;
}

class WorldClock extends Clock {
  final WorldTimeZone _timeZone;

  WorldClock(this._timeZone, DstStatus dstStatus)
      : super(timeZone: _timeZone, dstStatus: dstStatus);

  static WorldClock fromTimeZoneId(int timeZoneId, DstStatus dstStatus) {
    if (worldTimeZones.containsKey(timeZoneId) == false) {
      throw ClockError('Home time zone ID $timeZoneId does not exist.');
    }
    return WorldClock(worldTimeZones[timeZoneId]!, dstStatus);
  }

  @override
  WorldTimeZone get timeZone => _timeZone;
}

class ClockError implements Exception {
  final String message;

  ClockError(this.message);

  @override
  String toString() => 'ClockError: $message';
}
