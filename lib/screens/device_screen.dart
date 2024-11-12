import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:g_square/utils/constants.dart';

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
                    onPressed: () => onReadPressed(context, Command.casioWatchName),
                    child: const Text('Read Name')),
                ElevatedButton(
                    onPressed: () => onReadPressed(context, Command.casioAppInformation),
                    child: const Text('Read app info')),
                ElevatedButton(
                    onPressed: () => onReadPressed(context, Command.casioWatchCondition),
                    child: const Text('Read condition')),
                ElevatedButton(
                    onPressed: () => onDisconnectPressed(context),
                    child: const Text('Disconnect'))
              ].toList(),
            ))));
  }
}
