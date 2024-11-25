import 'package:g_square/models/time_zone.dart';

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

class HomeClock {
  HomeTimeZone timeZone;
  DstStatus dstStatus;

  HomeClock(this.timeZone, this.dstStatus);
}

class WorldClock {
  WorldTimeZone timeZone;
  DstStatus dstStatus;

  WorldClock(this.timeZone, this.dstStatus);
}