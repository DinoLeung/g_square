import 'package:g_square/models/command.dart';
import 'package:g_square/models/clock.dart';
import 'package:g_square/utils/bytes_converter.dart';

class Config {
  late HomeClock homeTime;
  late WorldClock worldTime1;
  late WorldClock worldTime2;
  late WorldClock worldTime3;
  late WorldClock worldTime4;
  late WorldClock worldTime5;

  void parseClocks(List<int> bytes) {
    if (bytes.first != Command.clock.code) {
      throw ConfigError(
          "Time zone settings message must starts with ${Command.clock.code.toRadixString(16)}");
    }

    if (bytes.length != 15) {
      throw ConfigError(
          "Time zone settings message must be 15 bytes in lengeh, e.g. 1d 00 01 03 02 7f 76 00 00 ff ff ff ff ff ff");
    }

    var position1 = bytes[1];
    var position2 = bytes[2];
    var dstStatuc1 = DstStatus.fromByte(bytes[3]);
    var dstStatuc2 = DstStatus.fromByte(bytes[4]);
    var timeZoneId1 = BytesConverter.bytesToInt([bytes[5], bytes[6]]);
    var timeZoneId2 = BytesConverter.bytesToInt([bytes[7], bytes[8]]);

    _setClocks(position1, timeZoneId1, dstStatuc1);
    _setClocks(position2, timeZoneId2, dstStatuc2);
  }

  void _setClocks(int position, int timeZoneId, DstStatus dstStatus) {
    switch (position) {
      case 0:
        homeTime = HomeClock.fromTimeZoneId(timeZoneId, dstStatus);
        break;
      case 1:
        worldTime1 = WorldClock.fromTimeZoneId(timeZoneId, dstStatus);
        break;
      case 2:
        worldTime2 = WorldClock.fromTimeZoneId(timeZoneId, dstStatus);
        break;
      case 3:
        worldTime3 = WorldClock.fromTimeZoneId(timeZoneId, dstStatus);
        break;
      case 4:
        worldTime4 = WorldClock.fromTimeZoneId(timeZoneId, dstStatus);
        break;
      case 5:
        worldTime5 = WorldClock.fromTimeZoneId(timeZoneId, dstStatus);
        break;
      default:
        throw ConfigError("Time zone position must be between 0-5.");
    }
  }

  List<List<int>> clocksPacket() {
    var suffix = [0xff, 0xff, 0xff, 0xff, 0xff];
    return [
      [
        Command.clock.code,
        ...BytesConverter.clocksPairToBytes(0, 1, homeTime, worldTime1),
        ...suffix
      ],
      [
        Command.clock.code,
        ...BytesConverter.clocksPairToBytes(2, 3, worldTime2, worldTime3),
        ...suffix
      ],
      [
        Command.clock.code,
        ...BytesConverter.clocksPairToBytes(4, 5, worldTime4, worldTime5),
        ...suffix
      ],
    ];
  }

  List<List<int>> timeZonesConfigsPacket() => [
        [Command.timeZoneConfig.code, 0, ...homeTime.timeZone.bytes],
        [Command.timeZoneConfig.code, 1, ...worldTime1.timeZone.bytes],
        [Command.timeZoneConfig.code, 2, ...worldTime2.timeZone.bytes],
        [Command.timeZoneConfig.code, 3, ...worldTime3.timeZone.bytes],
        [Command.timeZoneConfig.code, 4, ...worldTime4.timeZone.bytes],
        [Command.timeZoneConfig.code, 5, ...worldTime5.timeZone.bytes],
      ];

  List<List<int>> timeZonesNamesPacket() => [
        [Command.timeZoneName.code, 0, ...homeTime.timeZone.cityNameBytes],
        [Command.timeZoneName.code, 0, ...worldTime1.timeZone.cityNameBytes],
        [Command.timeZoneName.code, 0, ...worldTime2.timeZone.cityNameBytes],
        [Command.timeZoneName.code, 0, ...worldTime3.timeZone.cityNameBytes],
        [Command.timeZoneName.code, 0, ...worldTime4.timeZone.cityNameBytes],
        [Command.timeZoneName.code, 0, ...worldTime5.timeZone.cityNameBytes],
      ];
}

class ConfigError implements Exception {
  final String message;

  ConfigError(this.message);

  @override
  String toString() => 'ConfigError: $message';
}
