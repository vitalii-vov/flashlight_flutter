
import 'flashlight_flutter_platform_interface.dart';

class FlashlightFlutter {
  Future<String?> getPlatformVersion() {
    return FlashlightFlutterPlatform.instance.getPlatformVersion();
  }
}
