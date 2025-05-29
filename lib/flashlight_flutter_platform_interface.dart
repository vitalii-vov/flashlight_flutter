import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flashlight_flutter_method_channel.dart';

abstract class FlashlightFlutterPlatform extends PlatformInterface {
  FlashlightFlutterPlatform() : super(token: _token);
  static final Object _token = Object();
  static FlashlightFlutterPlatform _instance = FlashlightFlutterMethodChannel();
  static FlashlightFlutterPlatform get instance => _instance;

  static set instance(FlashlightFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isFlashAvailable() async {
    throw UnimplementedError('isFlashAvailable() has not been implemented.');
  }

  Future<bool> isTorchLevelAvailable() async {
    throw UnimplementedError('isTorchLevelAvailable() has not been implemented.');
  }

  Future<void> setTorchLevel(double torchLevel) async {
    throw UnimplementedError('setTorchLevel() has not been implemented.');
  }

  Future<double> getTorchLevel() async {
    throw UnimplementedError('getTorchLevel() has not been implemented.');
  }

  Future<void> turnOn() async {
    throw UnimplementedError('turnOn() has not been implemented.');
  }

  Future<void> turnOff() async {
    throw UnimplementedError('turnOff() has not been implemented.');
  }
}
