import 'flashlight_flutter_platform_interface.dart';

/// A Flutter plugin interface for controlling the device flashlight.
///
/// Provides methods to check flashlight availability, control power state,
/// and set or retrieve torch brightness level (if supported).
class FlashlightFlutter {
  /// Checks whether the device has a flashlight available.
  ///
  /// Returns `true` if a flashlight is available, otherwise `false`.
  Future<bool> isFlashAvailable() async {
    return await FlashlightFlutterPlatform.instance.isFlashAvailable();
  }

  /// Checks whether the device supports torch brightness level control.
  ///
  /// Returns `true` if setting the torch level is supported, otherwise `false`.
  Future<bool> isTorchLevelAvailable() async {
    return await FlashlightFlutterPlatform.instance.isTorchLevelAvailable();
  }

  /// Sets the torch brightness level (if supported).
  ///
  /// The [torchLevel] must be between `0.0` (off) and `1.0` (maximum brightness).
  ///
  /// **Note:** The value `0.0` is not allowed. To turn off the flashlight, use [turnOff] instead.
  Future<void> setTorchLevel(double torchLevel) async {
    return await FlashlightFlutterPlatform.instance.setTorchLevel(torchLevel);
  }

  /// Gets the current torch brightness level.
  ///
  /// Returns a value between `0.0` and `1.0`.
  Future<double> getTorchLevel() async {
    return await FlashlightFlutterPlatform.instance.getTorchLevel();
  }

  /// Turns on the flashlight using the previously set torch brightness level.
  ///
  /// If [setTorchLevel] was not called before, the flashlight will turn on at full brightness by default.
  Future<void> turnOn() async {
    return await FlashlightFlutterPlatform.instance.turnOn();
  }

  /// Turns off the flashlight.
  Future<void> turnOff() async {
    return await FlashlightFlutterPlatform.instance.turnOff();
  }
}
