package com.hwkim1127.country_detector

import android.content.ContentValues.TAG
import android.content.Context
import android.telephony.TelephonyManager
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.HashMap

/** CountryDetectorPlugin */
class CountryDetectorPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "country_detector")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "isoCountryCode" ->
          try {
            result.success(detectISOCountryCode())
          } catch (e: Exception) {
            result.error("android error", e.message, null)
          }
      "detectAll" ->
          try {
            val allCodes: MutableMap<String, String> = HashMap<String, String>()
            allCodes["sim"] = detectSIMCountryCode() ?: ""
            allCodes["network"] = detectNetworkCountryCode() ?: ""
            allCodes["locale"] = detectLocaleCountryCode() ?: ""
            Log.d(TAG, "allCodes: ${allCodes}")
            result.success(allCodes)
            // val sim = detectSIMCountryCode() ?: ""
            // val network = detectNetworkCountryCode() ?: ""
            // val locale = detectLocaleCountryCode() ?: ""
            // allCodes
            //     .apply {
            //       put("sim", sim)
            //       put("network", network)
            //       put("locale", locale)
            //     }
            //     .also { resultingMap -> result.success(resultingMap) }
          } catch (e: Exception) {
            result.error("android error", e.message, null)
          }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun detectISOCountryCode(): String? {
    return detectSIMCountryCode() ?: detectNetworkCountryCode() ?: detectLocaleCountryCode()
  }

  private fun detectSIMCountryCode(): String? {
    try {
      val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
      Log.d(TAG, "detectSIMCountry: ${telephonyManager.simCountryIso}")
      return telephonyManager.simCountryIso.uppercase()
    } catch (e: Exception) {
      throw e
    }
  }

  private fun detectNetworkCountryCode(): String? {
    try {
      val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
      Log.d(TAG, "detectNetworkCountry: ${telephonyManager.networkCountryIso}")
      return telephonyManager.networkCountryIso.uppercase()
    } catch (e: Exception) {
      throw e
    }
  }

  private fun detectLocaleCountryCode(): String? {
    try {
      val localeCountryISO = context.resources.configuration.locales[0].country
      Log.d(TAG, "detectLocaleCountry: $localeCountryISO")
      return localeCountryISO
    } catch (e: Exception) {
      throw e
    }
  }
}
