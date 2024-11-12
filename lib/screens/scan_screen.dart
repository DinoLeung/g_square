import 'dart:async';

import 'package:flutter/material.dart';
import 'package:g_square/screens/device_screen.dart';

import 'package:g_square/utils/connector.dart';
import 'package:g_square/utils/device.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // BluetoothDevice? _watch = null;
  // List<BluetoothService> _services = [];
  bool _isScanning = false;
  // bool _isConnected = false;
  // Map<String, List<int>> _characteristics = {};

  // GShockManager manager = GShockManager();
  Connector connector = Connector();

  @override
  void initState() {
    super.initState();

    connector.deviceConnectionStream.listen((connection) {
      print("Connected");
      navigateToDeviceScreen(connection);
    });

    // manager.connection.connectedWatchStream.listen((watch) {
    //   _watch = watch;
    //   if (watch != null) {
    //     print("Connected");
    //     // print(watch.servicesList);
    //   }
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });

    // manager.connection.watchServicesStream.listen((services) {
    //   _services = services;
    //   services.forEach((service) {
    //     // print(service);
    //   });
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });

    connector.isScanningStream.listen((isScanning) {
      _isScanning = isScanning;
      if (mounted) {
        setState(() {});
      }
    });

    // manager.connection.isScanningStream.listen((isScanning) {
    //   _isScanning = isScanning;
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });

    // manager.connection.connectionStateStream.listen((status) async {
    //   _isConnected = status == BluetoothConnectionState.connected;
    //   // if (_isConnected && manager.connectedWatch != null) {
    //   //   var services = await manager.discoverServices(manager.connectedWatch!);
    //   //   services.forEach((service) {
    //   //     service.characteristics.forEach((c) async {
    //   //       if (c.properties.read) {
    //   //         List<int> value = await c.read();
    //   //         print("${c.characteristicUuid}: ${value}");
    //   //         _characteristics.addAll({c.characteristicUuid.toString(): value});
    //   //       }
    //   //     });
    //   //   });
    //   // } else {
    //   //   _characteristics.clear();
    //   // }
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
  }

  @override
  void dispose() {
    // manager.dispose();
    connector.dispose();
    super.dispose();
  }

  void navigateToDeviceScreen(Device device) {
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => DeviceScreen(device: device),
        settings: const RouteSettings(name: '/DeviceScreen'));
    Navigator.of(context).push(route);
  }

  Future onScanPressed() async {
    // await manager.connection.scanAndConnect();
    await connector.scanAndConnect();

    if (mounted) {
      setState(() {});
    }
  }

  // Future onDisconnectPressed() async {
  //   await manager.disconnect();

  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  Future onStopPressed() async {
    try {
      // await manager.connection.stopScanning();
      await connector.stopScanning();
    } catch (e) {
      // Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e), success: false);
    }
    if (mounted) {
      setState(() {});
    }
  }

  // Widget buildScanButton(BuildContext context) {
  //   // if (FlutterBluePlus.isScanningNow) {
  //   if (_isScanning) {
  //     return FloatingActionButton(
  //       child: const Icon(Icons.stop),
  //       onPressed: onStopPressed,
  //       backgroundColor: Colors.red,
  //     );
  //   } else if (_isConnected) {
  //     return FloatingActionButton(
  //         child: const Text("DISCONNECT"),
  //         onPressed: onDisconnectPressed,
  //         backgroundColor: Colors.blue);
  //   } else {
  //     return FloatingActionButton(
  //         child: const Text("SCAN"), onPressed: onScanPressed);
  //   }
  // }

  Widget buildConnectButton(BuildContext context) {
    if (_isScanning) {
      return ElevatedButton(onPressed: onStopPressed, child: const Text('Stop'));
    } else {
      return ElevatedButton(onPressed: onScanPressed, child: const Text('Scan'));
    }
  }

  // Widget buildBody(BuildContext context) {
  //   // return Center(
  //   //   child: Column(
  //   //     children: [
  //   //       Text("isScanning: ${_isScanning}, isConnected: ${_isConnected}"),
  //   //       buildList(context)
  //   //     ],
  //   //   )
  //   // );
  //   return Text("isScanning: ${_isScanning}, isConnected: ${_isConnected}");
  // }

  // Widget buildList(BuildContext context) {
  //   return ListView(
  //       children: _services
  //           .map((service) => Text(
  //               "${service.serviceUuid.toString()}: ${service.isPrimary ? "Primary" : "Not Primary"}"))
  //           .toList());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connect to watch'),
        ),
        body: Center(child: buildConnectButton(context)));

    //   return ScaffoldMessenger(
    //     // key: Snackbar.snackBarKeyB,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Find Devices'),
    //       ),
    //       body: buildBody(context),
    //       // body: RefreshIndicator(
    //       //   onRefresh: onRefresh,
    //       //   child: ListView(
    //       //     children: <Widget>[
    //       //       // ..._buildSystemDeviceTiles(context),
    //       //       // ..._buildScanResultTiles(context),
    //       //     ],
    //       //   ),
    //       // ),
    //       floatingActionButton: buildScanButton(context),
    //     ),
    //   );
  }
}
