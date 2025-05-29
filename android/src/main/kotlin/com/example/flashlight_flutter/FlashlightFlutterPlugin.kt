package com.example.flashlight_flutter

import android.content.Context
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlashlightFlutterPlugin: FlutterPlugin, MethodCallHandler {
  
  private lateinit var context: Context
  private lateinit var cameraManager: CameraManager
  private var flashCameraId: String? = null
  private var maxTorchLevel = 1
  private var isTorchLevelAvailable = false
  private var isFlashAvailable = false
  private lateinit var channel : MethodChannel

  private var torchLevel = 1.0;

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flashlight_flutter")
    channel.setMethodCallHandler(this)

    context = flutterPluginBinding.applicationContext

    cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    for (id in cameraManager.cameraIdList) {
      val characteristics = cameraManager.getCameraCharacteristics(id)
      isFlashAvailable = characteristics.get(CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
      if (isFlashAvailable) {
        flashCameraId = id
        findMaxTorchLevel(flashCameraId!!)
        break
      }
    }
  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "isFlashAvailable" -> {
          result.success(isFlashAvailable)
        }
        "isTorchLevelAvailable" -> {
          result.success(isTorchLevelAvailable)
        }
        "setTorchLevel" -> {
          torchLevel = ((call.argument<Double>("torchLevel") ?: 1.0).coerceIn(0.0, 1.0))
        }
        "getTorchLevel" -> {
          result.success(torchLevel)
        }
        "turnOn" -> {
          turnOn()
        }
        "turnOff" -> {
          turnOff()
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun findMaxTorchLevel(cameraId: String) {
    val characteristics = cameraManager.getCameraCharacteristics(cameraId)

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      isTorchLevelAvailable = try {
        characteristics.keys.contains(CameraCharacteristics.FLASH_INFO_STRENGTH_MAXIMUM_LEVEL)
      } catch (e: Exception) {
        false
      }

      if (!isTorchLevelAvailable) return

      maxTorchLevel = characteristics.get(CameraCharacteristics.FLASH_INFO_STRENGTH_MAXIMUM_LEVEL) ?: 1
    } else {
      isTorchLevelAvailable = false
    }
  }

  private fun getCurrentTorchLevel(): Int {
    val min = 1
    val max = maxTorchLevel
    return ((max - min) * torchLevel).toInt() + min
  }

  @RequiresApi(Build.VERSION_CODES.M)
  private fun turnOn() {
    if (!isFlashAvailable) {
      return
    }

    if (isTorchLevelAvailable && Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      cameraManager.turnOnTorchWithStrengthLevel(flashCameraId!!, getCurrentTorchLevel())
    }
    else
      cameraManager.setTorchMode(flashCameraId!!, true)
  }

  @RequiresApi(Build.VERSION_CODES.M)
  private fun turnOff() {
    if (!isFlashAvailable) return
    cameraManager.setTorchMode(flashCameraId!!, false)
  }
}
