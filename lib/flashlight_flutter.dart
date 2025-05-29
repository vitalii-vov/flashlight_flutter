import 'flashlight_flutter_platform_interface.dart';

class FlashlightFlutter {
  Future<bool> isFlashAvailable() async {
    return await FlashlightFlutterPlatform.instance.isFlashAvailable();
  }

  Future<bool> isTorchLevelAvailable() async {
    return await FlashlightFlutterPlatform.instance.isTorchLevelAvailable();
  }

  //  torchLevel from 0 to 1
  Future<void> setTorchLevel(double torchLevel) async {
    return await FlashlightFlutterPlatform.instance.setTorchLevel(torchLevel);
  }

  Future<double> getTorchLevel() async {
    return await FlashlightFlutterPlatform.instance.getTorchLevel();
  }

  Future<void> turnOn() async {
    return await FlashlightFlutterPlatform.instance.turnOn();
  }

  Future<void> turnOff() async {
    return await FlashlightFlutterPlatform.instance.turnOff();
  }
}
