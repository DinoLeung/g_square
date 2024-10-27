import 'package:flutter/material.dart';

import 'package:g_square/utils/device.dart';

class DeviceScreen extends StatefulWidget {
  final Device device;

  const DeviceScreen({super.key, required this.device});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.device.dispose();
    super.dispose();
  }

  void onDisconnectPressed(BuildContext context) async {
    await widget.device.disconnect();
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connected watch'),
          automaticallyImplyLeading: false
        ),
        body: Center(
          child: PopScope(
              canPop: false,
              child: ElevatedButton(
                  onPressed: () => onDisconnectPressed(context),
                  child: const Text('Disconnect'))),
        ));
  }
}
