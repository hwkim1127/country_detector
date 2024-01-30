import 'package:country_detector/country_detector.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'country_detector_method_channel.dart';

abstract class CountryDetectorPlatform extends PlatformInterface {
  /// Constructs a CountryDetectorPlatform.
  CountryDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static CountryDetectorPlatform _instance = MethodChannelCountryDetector();

  /// The default instance of [CountryDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelCountryDetector].
  static CountryDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CountryDetectorPlatform] when
  /// they register themselves.
  static set instance(CountryDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> isoCountryCode() {
    throw UnimplementedError(
        'detectISOCountryCode() has not been implemented.');
  }

  Future<AllCountries> detectAll() {
    throw UnimplementedError('detectAll() has not been implemented.');
  }
}
