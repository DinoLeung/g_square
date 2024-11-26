import 'dart:async';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:g_square/utils/device.dart';
import 'package:g_square/constants/bluetooth_uuid.dart';

class Connector {
  Connector() {
    _adapterStateSubscription = FlutterBluePlus.adapterState
        .listen(_handleAdapterStateChange, onError: (e) => print(e));

    _scanResultsSubscription = FlutterBluePlus.onScanResults
        .listen(_handleScanResults, onError: (e) => print(e));

    _isScanningStreamController.addStream(FlutterBluePlus.isScanning);
  }

  void dispose() {
    _adapterStateSubscription.cancel();
    _scanResultsSubscription.cancel();

    _isScanningStreamController.close();
    _deviceConnectionStreamController.close();
  }

  late final StreamSubscription<BluetoothAdapterState>
      _adapterStateSubscription;
  void _handleAdapterStateChange(BluetoothAdapterState state) async {
    switch (state) {
      case BluetoothAdapterState.on:
        print("We good");
      case BluetoothAdapterState.off:
        if (Platform.isAndroid) await FlutterBluePlus.turnOn();
      case BluetoothAdapterState.unauthorized:
        print("BT permission deny");
      case BluetoothAdapterState.unavailable:
        print("BT hardware is not avilable");
      default:
        print("poop");
    }
  }

  late final StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  void _handleScanResults(List<ScanResult> results) async {
    if (results.isNotEmpty) {
      await stopScanning();
      var watch = results.first.device;
      await connect(watch);
    }
  }

  // Scanning states
  final StreamController<bool> _isScanningStreamController =
      StreamController<bool>.broadcast();
  Stream<bool> get isScanningStream => _isScanningStreamController.stream;

  // Watch connetion
  final StreamController<Device> _deviceConnectionStreamController =
      StreamController.broadcast();
  Stream<Device> get deviceConnectionStream =>
      _deviceConnectionStreamController.stream;

  // The connection logic is in _scanResultsSubscription
  Future<void> scanAndConnect({Duration? timeout}) => FlutterBluePlus.startScan(
      timeout: timeout, withServices: [casioServiceUUID]);

  Future<void> stopScanning() async => FlutterBluePlus.stopScan();

  Future<void> connect(BluetoothDevice watch) async {
    try {
      await watch.connect();
      List<BluetoothService> services = await watch.discoverServices();

      var allServices = services.firstWhere(
          (service) => service.uuid == allFeaturesCharacteristicUUID);
      var requestCharacteristic = allServices.characteristics.firstWhere(
          (characteristic) => characteristic.uuid == requestCharacteristicUUID);
      var ioCharacteristic = allServices.characteristics.firstWhere(
          (characteristic) => characteristic.uuid == ioCharacteristicUUID);

      _deviceConnectionStreamController
          .add(Device(watch, requestCharacteristic, ioCharacteristic));
    } on FlutterBluePlusException catch (e) {
      print(e.toString());
      await watch.disconnect();
    } on StateError {
      print("Device not supported");
      await watch.disconnect();
    } catch (e) {
      print("Error while connecting: ${e.toString()}");
      await watch.disconnect();
    }
  }
}
