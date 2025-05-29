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
  final _flashlightPlugin = FlashlightFlutter();
  bool _flashAvailable = false;
  bool _torchLevelAvailable = false;
  double _torchLevel = 1;
  bool _light = false;

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
            Slider(
              min: 0.1,
              max: 1,
              value: _torchLevel,
              divisions: 9,
              label: '${_torchLevel * 100}%',
              onChanged:
                  _torchLevelAvailable
                      ? (double value) async {
                        await _setTorchLevel(value);
                      }
                      : null,
            ),

            ElevatedButton(
              onPressed: () async {
                final torchLevel = await _flashlightPlugin.getTorchLevel();
                setState(() {
                  _torchLevel = torchLevel;
                });
              },
              child: Text('Get torch level'),
            ),

            SizedBox(height: 40),
            Text(_light ? 'ON' : 'OFF'),
            Switch(
              value: _light,
              onChanged: (bool value) async {
                await _toggle(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggle(bool value) async {
    if (value) {
      await _flashlightPlugin.turnOn();
    } else {
      await _flashlightPlugin.turnOff();
    }
    setState(() {
      _light = value;
    });
  }

  Future<void> _setTorchLevel(double value) async {
    await _flashlightPlugin.setTorchLevel(value);
    setState(() {
      _torchLevel = value;
    });
    _toggle(true);
  }
}
