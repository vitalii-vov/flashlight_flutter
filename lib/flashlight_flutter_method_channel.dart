import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flashlight_flutter_platform_interface.dart';

class FlashlightFlutterMethodChannel extends FlashlightFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flashlight_flutter');

  @override
  Future<bool> isFlashAvailable() async {
    return await methodChannel.invokeMethod('isFlashAvailable');
  }

  @override
  Future<bool> isTorchLevelAvailable() async {
    return await methodChannel.invokeMethod('isTorchLevelAvailable');
  }

  @override
  Future<void> setTorchLevel(double torchLevel) async {
    return await methodChannel.invokeMethod('setTorchLevel', {
      'torchLevel': torchLevel,
    });
  }

  @override
  Future<double> getTorchLevel() async {
    return await methodChannel.invokeMethod('getTorchLevel');
  }

  @override
  Future<void> turnOn() async {
    await methodChannel.invokeMethod('turnOn');
  }

  @override
  Future<void> turnOff() async {
    await methodChannel.invokeMethod('turnOff');
  }
}
