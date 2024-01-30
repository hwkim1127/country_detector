import 'package:country_detector/country_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'country_detector_platform_interface.dart';

/// An implementation of [CountryDetectorPlatform] that uses method channels.
class MethodChannelCountryDetector extends CountryDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('country_detector');

  /// invokes method channel isoCountryCode
  @override
  Future<String?> isoCountryCode() async {
    final countryCode =
        await methodChannel.invokeMethod<String>('isoCountryCode');
    return countryCode;
  }

  /// invokes method channel detectAll
  @override
  Future<AllCountries> detectAll() async {
    final allCodes =
        await methodChannel.invokeMethod<Map<dynamic, dynamic>>('detectAll');
    return AllCountries(
      sim: allCodes!['sim'],
      network: allCodes['network'],
      locale: allCodes['locale'],
    );
  }
}
