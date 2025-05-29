import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flashlight_flutter_method_channel.dart';

abstract class FlashlightFlutterPlatform extends PlatformInterface {
  /// Constructs a FlashlightFlutterPlatform.
  FlashlightFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlashlightFlutterPlatform _instance = MethodChannelFlashlightFlutter();

  /// The default instance of [FlashlightFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlashlightFlutter].
  static FlashlightFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlashlightFlutterPlatform] when
  /// they register themselves.
  static set instance(FlashlightFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
