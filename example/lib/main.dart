import 'package:flashlight_flutter/flashlight_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _flashAvailable = false;
  bool _torchLevelAvailable = false;
  double _torchLevel = .0;
  final _flashlightPlugin = FlashlightFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool isFlashAvailable = await _flashlightPlugin.isFlashAvailable();
    bool isTorchLevelAvailable = await _flashlightPlugin.isTorchLevelAvailable();

    if (!mounted) return;

    setState(() {
      _flashAvailable = isFlashAvailable;
      _torchLevelAvailable = isTorchLevelAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          children: [
            Text('Flash available: $_flashAvailable'),
            Text('Torch available: $_torchLevelAvailable'),
            Text('Torch level: $_torchLevel'),
            ElevatedButton(
              onPressed: () async {
                final torchLevel = await _flashlightPlugin.getTorchLevel();
                setState(() {
                  _torchLevel = torchLevel;
                });
              },
              child: Text('Get torch level'),
            ),

            ElevatedButton(
              onPressed: () async {
                await _flashlightPlugin.setTorchLevel(0.5);
                final torchLevel = await _flashlightPlugin.getTorchLevel();
                setState(() {
                  _torchLevel = torchLevel;
                });
              },
              child: Text('Set torch level: 0.5'),
            ),

            ElevatedButton(
              onPressed: () async {
                await _flashlightPlugin.setTorchLevel(0.7);
                final torchLevel = await _flashlightPlugin.getTorchLevel();
                setState(() {
                  _torchLevel = torchLevel;
                });
              },
              child: Text('Set torch level: 0.7'),
            ),

            ElevatedButton(
              onPressed: () async {
                await _flashlightPlugin.turnOn();
              },
              child: Text('ON'),
            ),

            ElevatedButton(
              onPressed: () async {
                await _flashlightPlugin.turnOff();
              },
              child: Text('OFF'),
            ),
          ],
        ),
      ),
    );
  }
}
