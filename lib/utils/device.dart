import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:g_square/utils/constants.dart';

class Device {
  Device(this._watch, this._requestCharacteristic, this._ioCharacteristic) {
    _connectionStateSubscription = _watch.connectionState
        .listen(_connectionStateOnData, onError: (e) => print(e));

    _ioCharacteristicSubscription = _ioCharacteristic.onValueReceived
        .listen(_ioCharacteristicOndata, onError: (e) => print(e));
    _ioCharacteristic.setNotifyValue(true);

    print(_requestCharacteristic.properties);
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
    // TODO: debugging return values.
    // app info 0x22 returns 22 2d a8 5e 24 8c 46 8c 74 83 42 02
    if (data.first == Command.watchName.code) {
      print(String.fromCharCodes(data.where((byte) => byte != 0)));
    } else {
      print(
          data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(' '));
    }
  }

  Future<void> disconnect() async {
    await _watch.disconnect();
  }

  Future<bool> subscribeToIO() => _ioCharacteristic.setNotifyValue(true);

  Future request(Command c) =>
      _requestCharacteristic.write([c.code], withoutResponse: true);

  Future write(Command c, List<int> data) =>
      _ioCharacteristic.write([c.code, ...data]);

  // Future<void> getSettings(BluetoothDevice watch) async {
  //   watch.
  // }
}
