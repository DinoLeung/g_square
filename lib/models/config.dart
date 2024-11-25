import 'package:g_square/models/command.dart';
import 'package:g_square/models/clock.dart';
import 'package:g_square/models/time_zone.dart';
import 'package:g_square/utils/bytes_converter.dart';

class Config {
  late Clock homeTime;
  late Clock worldTime1;
  late Clock worldTime2;
  late Clock worldTime3;
  late Clock worldTime4;
  late Clock worldTime5;

  void parseClocks(List<int> bytes) {
    if (bytes.first != Command.clock.code) {
      throw ConfigError(
          "Time zone settings message must starts with ${Command.clock.code.toRadixString(16)}");
    }

    if (bytes.length != 15) {
      throw ConfigError(
          "Time zone settings message must be 15 bytes in lengeh, e.g. 1d 00 01 03 02 7f 76 00 00 ff ff ff ff ff ff");
    }

    var pos1 = bytes[1];
    var pos2 = bytes[2];
    var dst1 = DstStatus.fromByte(bytes[3]);
    var dst2 = DstStatus.fromByte(bytes[4]);
    print(pos1);
    print([bytes[5].toRadixString(16), bytes[6].toRadixString(16)]);
    var timezone1 = TimeZone.fromIdentifier(BytesConverter.bytesToInt([bytes[5], bytes[6]]));
    print(pos2);
    print([bytes[7].toRadixString(16), bytes[8].toRadixString(16)]);
    var timezone2 = TimeZone.fromIdentifier(BytesConverter.bytesToInt([bytes[7], bytes[8]]));

    _setClocks(pos1, timezone1, dst1);
    _setClocks(pos2, timezone2, dst2);
  }

  void _setClocks(int position, TimeZone timeZone, DstStatus dstStatus) {
    var clock = Clock(dstStatus, timeZone);
    switch (position) {
      case 0:
        homeTime = clock;
        break;
      case 1:
        worldTime1 = clock;
        break;
      case 2:
        worldTime2 = clock;
        break;
      case 3:
        worldTime3 = clock;
        break;
      case 4:
        worldTime4 = clock;
        break;
      case 5:
        worldTime5 = clock;
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
        [
          Command.timeZoneName.code,
          0,
          ...homeTime.timeZone.cityNameBytes
        ],
        [
          Command.timeZoneName.code,
          0,
          ...worldTime1.timeZone.cityNameBytes
        ],
        [
          Command.timeZoneName.code,
          0,
          ...worldTime2.timeZone.cityNameBytes
        ],
        [
          Command.timeZoneName.code,
          0,
          ...worldTime3.timeZone.cityNameBytes
        ],
        [
          Command.timeZoneName.code,
          0,
          ...worldTime4.timeZone.cityNameBytes
        ],
        [
          Command.timeZoneName.code,
          0,
          ...worldTime5.timeZone.cityNameBytes
        ],
      ];
}

class ConfigError implements Exception {
  final String message;

  ConfigError(this.message);

  @override
  String toString() => 'ConfigError: $message';
}
