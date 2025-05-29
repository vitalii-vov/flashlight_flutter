import Flutter
import UIKit
import AVFoundation

public class FlashlightFlutterPlugin: NSObject, FlutterPlugin {
    
    private var captureDevice: AVCaptureDevice?
    private var torchLevel: Float = 1.0
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flashlight_flutter", binaryMessenger: registrar.messenger())
        let instance = FlashlightFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    override init() {
        super.init()
        captureDevice = AVCaptureDevice.default(for: .video)
    }
    
    private var isFlashAvailable: Bool {
        guard let device = captureDevice else { return false }
        return device.hasFlash || device.hasTorch
    }
    
    private var isTorchLevelAvailable: Bool {
        return isFlashAvailable
    }
    
    private func getMaxTorchLevel() -> Float {
        guard let device = captureDevice else { return 1.0 }
        let max = AVCaptureDevice.maxAvailableTorchLevel
        return min(torchLevel, max)
    }
    
    private func toggle(on: Bool) {
        guard let device = captureDevice, isFlashAvailable else { return }
        
        do {
            try device.lockForConfiguration()
            
            if on {
                let level = getMaxTorchLevel()
                if device.hasTorch {
                    try device.setTorchModeOn(level: level)
                }
                if device.hasFlash {
                    device.flashMode = .on
                }
            } else {
                if device.hasTorch {
                    device.torchMode = .off
                }
                if device.hasFlash {
                    device.flashMode = .off
                }
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Flashlight toggle error: \(error)")
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isFlashAvailable":
            result(isFlashAvailable)
            
        case "isTorchLevelAvailable":
            result(isTorchLevelAvailable)
            
        case "setTorchLevel":
            if let args = call.arguments as? [String: Any],
               let level = args["torchLevel"] as? Double {
                torchLevel = Float(level).clamped(to: 0.0...1.0)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "torchLevel not provided", details: nil))
            }
            
        case "getTorchLevel":
            result(torchLevel)
            
        case "turnOn":
            toggle(on: true)
            result(nil)
            
        case "turnOff":
            toggle(on: false)
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

private extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

