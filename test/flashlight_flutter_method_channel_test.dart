import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashlight_flutter/flashlight_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  FlashlightFlutterMethodChannel platform = FlashlightFlutterMethodChannel();
  const MethodChannel channel = MethodChannel('flashlight_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
