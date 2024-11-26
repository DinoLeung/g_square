import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:g_square/models/command.dart';
import 'package:g_square/utils/device.dart';

class DeviceScreen extends StatefulWidget {
  final Device device;

  const DeviceScreen({super.key, required this.device});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late final StreamSubscription<BluetoothConnectionState>
      _connectionSubscription;

  @override
  void initState() {
    super.initState();

    _connectionSubscription =
        widget.device.connectionStateStream.listen((state) {
      if (state == BluetoothConnectionState.disconnected) {
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.device.dispose();
    _connectionSubscription.cancel();
    super.dispose();
  }

  void onDisconnectPressed(BuildContext context) async {
    await widget.device.disconnect();
  }

  void onReadPressed(BuildContext context, Command command) async {
    await widget.device.request(command);
  }

  // void onReadDstPressed(BuildContext context) async {
  //   List<int>.filled(3, 0).forEach((_) async {
  //     await widget.device.request(Command.clock);
  //   });
  // }

  void onSyncTimePressed(BuildContext context) async {
    // TODO: try reading timezone config before writing
    // TODO: write clocks last
    await widget.device.writeClocks();
    // await widget.device.writeTimeZones();
    await widget.device.writeTime();
  }

  void onGetClockPressed(BuildContext context) async {
    await widget.device.requestClocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Connected watch'),
            automaticallyImplyLeading: false),
        body: PopScope(
            canPop: false,
            child: Center(
                child: ListView(
              children: [
                ElevatedButton(
                    onPressed: () => onReadPressed(context, Command.watchName),
                    child: const Text('Read Name')),
                ElevatedButton(
                    onPressed: () =>
                        onReadPressed(context, Command.appInformation),
                    child: const Text('Read app info')),
                ElevatedButton(
                    onPressed: () =>
                        onReadPressed(context, Command.watchCondition),
                    child: const Text('Read condition')),
                ElevatedButton(
                    onPressed: () => onGetClockPressed(context),
                    child: const Text('Get Clocks')),
                ElevatedButton(
                    onPressed: () => onSyncTimePressed(context),
                    child: const Text('Sync time')),
                ElevatedButton(
                    onPressed: () => onDisconnectPressed(context),
                    child: const Text('Disconnect'))
              ].toList(),
            ))));
  }
}
