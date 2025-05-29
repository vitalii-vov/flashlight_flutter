# flashlight_flutter

Flutter plugin for LED control on iOS and Android.
https://pub.dev/packages/flashlight_flutter

&nbsp;<br>
## Installation
```
flutter pub add flashlight_flutter
```

&nbsp;<br>
## Usage

Create the object of FlashlightFlutter. If you use it in different places, ensure you use DI or singleton.
```Dart
final _flash = FlashlightFlutter();

Future<void> example() async {

  //  check if the flash is available
  bool isFlashAvailable = await _flash.isFlashAvailable();
  
  if (isFlashAvailable) {
  
    //  check if the torch level is available.
    bool isTorchLevelAvailable = await _flash.isTorchLevelAvailable();
  
    if (isTorchLevelAvailable) {
  
      //  set the brightness level in the range of (0.0;1.0]
      await _flash.setTorchLevel(0.5);
  
      //  get current brightness level
      final torchLevel = await _flash.getTorchLevel();
  
      //  turn on brightness
      await _flash.turnOn();
  
      //  turn off brightness
      await _flash.turnOff();
    }
  }
}
```
