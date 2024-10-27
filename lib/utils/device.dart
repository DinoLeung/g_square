import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:g_square/utils/constants.dart';

class Device {
  Device(this._watch, this._services) {
    _connectionStateSubscription = _watch.connectionState
        .listen(_connectionStateOnData, onError: (e) => print(e));

    // DEBUGGING SERVIECES
    for (var s in _services) {
      // print("Service: ${s.uuid}");
      for (var c in s.characteristics) {
        if (c.uuid == readCharacteristicUUID) {
          // print("READ CHARACTERISTIC: $c");
          readCharacteristic = c;
        }
        if (c.uuid == writeCharacteristicUUID) {
          // print("WRITE CHARACTERISTIC: $c");
          writeCharacteristic = c;
        }
        // print("Characteristic: ${c.uuid} ${c.properties}");
      }
    }

    bool isInitialised =
        readCharacteristic != null && writeCharacteristic != null;

    if (!isInitialised) {
      throw Exception('Unsupported device');
    }
  }

  void dispose() {
    _connectionStateSubscription.cancel();
    _connectionStateStreamController.close();
  }

  final BluetoothDevice _watch;
  final List<BluetoothService> _services;
  late final BluetoothCharacteristic readCharacteristic;
  late final BluetoothCharacteristic writeCharacteristic;

  List<BluetoothService> get watchServices => _watch.servicesList;

  // Connection States
  final StreamController<BluetoothConnectionState>
      _connectionStateStreamController = StreamController.broadcast();
  Stream<BluetoothConnectionState> get connectionStateStream =>
      _connectionStateStreamController.stream;

  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  BluetoothConnectionState get connectionState => _connectionState;
  // bool get isConnected =>
  //     _connectionState == BluetoothConnectionState.connected;

  late final StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  void _connectionStateOnData(BluetoothConnectionState state) {
    _connectionState = state;
    _connectionStateStreamController.add(state);
    // if (state == BluetoothConnectionState.disconnected) {
    //   disconnect();
    // }
  }

  Future<void> disconnect() async {
    await _watch.disconnect();
  }

  // Future<void> getSettings(BluetoothDevice watch) async {
  //   watch.
  // }
}
