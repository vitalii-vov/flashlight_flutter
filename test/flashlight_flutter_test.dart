import 'package:flutter_test/flutter_test.dart';
import 'package:flashlight_flutter/flashlight_flutter.dart';
import 'package:flashlight_flutter/flashlight_flutter_platform_interface.dart';
import 'package:flashlight_flutter/flashlight_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlashlightFlutterPlatform
    with MockPlatformInterfaceMixin
    implements FlashlightFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlashlightFlutterPlatform initialPlatform = FlashlightFlutterPlatform.instance;

  test('$MethodChannelFlashlightFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlashlightFlutter>());
  });

  test('getPlatformVersion', () async {
    FlashlightFlutter flashlightFlutterPlugin = FlashlightFlutter();
    MockFlashlightFlutterPlatform fakePlatform = MockFlashlightFlutterPlatform();
    FlashlightFlutterPlatform.instance = fakePlatform;

    expect(await flashlightFlutterPlugin.getPlatformVersion(), '42');
  });
}
