import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:g_square/models/command.dart';
import 'package:g_square/models/config.dart';
import 'package:g_square/utils/bytes_converter.dart';

class Device {
  Config config = Config();

  Device(this._watch, this._requestCharacteristic, this._ioCharacteristic) {
    _connectionStateSubscription = _watch.connectionState
        .listen(_connectionStateOnData, onError: (e) => print(e));

    _ioCharacteristicSubscription = _ioCharacteristic.onValueReceived
        .listen(_ioCharacteristicOndata, onError: (e) => print(e));
    _ioCharacteristic.setNotifyValue(true);
  }

  void dispose() {
    _connectionStateSubscription.cancel();
    _ioCharacteristicSubscription.cancel();
    _connectionStateStreamController.close();
  }

  final BluetoothDevice _watch;
  final BluetoothCharacteristic _requestCharacteristic;
  final BluetoothCharacteristic _ioCharacteristic;

  List<BluetoothService> get watchServices => _watch.servicesList;

  // Connection States
  final StreamController<BluetoothConnectionState>
      _connectionStateStreamController = StreamController.broadcast();
  Stream<BluetoothConnectionState> get connectionStateStream =>
      _connectionStateStreamController.stream;

  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  BluetoothConnectionState get connectionState => _connectionState;

  late final StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  void _connectionStateOnData(BluetoothConnectionState state) {
    _connectionState = state;
    _connectionStateStreamController.add(state);
  }

  late final StreamSubscription<List<int>> _ioCharacteristicSubscription;
  void _ioCharacteristicOndata(List<int> data) {
    switch (Command.fromCode(data.first)) {
      case Command.watchName:
        print(String.fromCharCodes(data.where((byte) => byte != 0)));
        break;
      case Command.clock:
        config.parseClocks(data);
        break;
      default:
        print(data
            .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
            .join(' '));
    }
  }

  Future<void> disconnect() async {
    await _watch.disconnect();
  }

  Future<bool> subscribeToIO() => _ioCharacteristic.setNotifyValue(true);

  Future request(Command c) =>
      _requestCharacteristic.write([c.code], withoutResponse: true);

  Future write(List<int> data) => _ioCharacteristic.write(data);

  Future requestClocks() async {
    for (var _ in List<int>.filled(3, 0)) {
      await request(Command.clock);
    }
  }

  Future writeClocks() async {
    for (var packet in config.clocksPacket()) {
      await write(packet);
    }
  }

  Future requestTimeZoneConfigs() async {
    for (var _ in List<int>.filled(6, 0)) {
      await request(Command.timeZoneConfig);
    }
  }

  Future writeTimeZoneConfigs() async {
    for (var packet in config.timeZonesConfigsPacket()) {
      await write(packet);
    }
  }

  Future requestTimeZoneNames() async {
    for (var _ in List<int>.filled(6, 0)) {
      await request(Command.timeZoneName);
    }
  }

  Future writeTimeZoneNames() async {
    for (var packet in config.timeZonesNamesPacket()) {
      await write(packet);
    }
  }

  Future writeTime(
      {Duration offset = const Duration(milliseconds: 300)}) async {
    DateTime now = await config.homeTime.getCurrentDateTime();
    DateTime offsetTime = now.add(offset);
    List<int> datetimeData = BytesConverter.dateTimeToBytes(offsetTime);
    List<int> packet = [Command.currentTime.code, ...datetimeData, 1];
    await write(packet);
  }

  // sync time
  // r 1d x3 (read timezone + dst status)
  // 1d 00 01 03 02 7f 76 00 00 ff ff ff ff ff ff
  // 1d 02 03 00 02 7a 00 19 01 ff ff ff ff ff ff
  // 1d 04 05 02 03 5f 00 0f 01 ff ff ff ff ff ff
  // r 24 00, r 24 01... r 24 05
  // 24 00 01 c0 41 70 dd 39 2b 9a b8 40 61 56 1b d3 2f bd 5d 00
  // 24 01 01 40 49 c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  // 24 02 01 40 36 47 c8 4b 5d cc 64 40 5c 8a d7 1f 36 26 2d 03
  // 24 03 01 40 41 d8 41 35 54 75 a3 40 61 76 22 7d 02 8a 1e 02
  // 24 04 01 40 4b fa 04 18 93 74 bc c0 09 81 93 b3 a6 8b 1a 04
  // 24 05 01 c0 40 ef 09 e9 8d cd b3 40 62 e6 9f a9 7e 13 2b 00
  // w 1d x3 (write timezone)
  // r 1e x5 (read dst info)
  // 1e 00 7f 76 26 04 04
  // 1e 01 00 00 00 00 00
  // 1e 02 7a 00 20 04 00
  // 1e 03 19 01 24 04 00
  // 1e 04 5f 00 00 04 02
  // 1e 05 0f 01 28 04 04
  // w 1e x5
  // w 24 x5
  // r 1f 00, r 1f 01... r 1f 05 (read timezone name)
  // w 1f x5 (write timezone name)
  // w 09
}
