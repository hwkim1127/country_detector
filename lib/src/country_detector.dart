import 'country_detector_platform_interface.dart';

class CountryDetector {
  /// Returns whatever available country code detected
  /// First From SIM, then Network, then Locale
  /// iOS does not support Network Country Code
  Future<String?> isoCountryCode() {
    return CountryDetectorPlatform.instance.isoCountryCode();
  }

  /// This code returns country from all available method
  /// iOS has no support for Network Country Code
  Future<AllCountries> detectAll() {
    return CountryDetectorPlatform.instance.detectAll();
  }
}

/// Class for all country codes detected
class AllCountries {
  final String sim;
  final String network;
  final String locale;

  /// records result from SIM, Network and Locale
  AllCountries({
    this.sim = '',
    this.network = '',
    this.locale = '',
  });

  @override
  bool operator ==(Object other) =>
      other is AllCountries &&
      (other.sim == sim && other.network == network && other.locale == locale);

  @override
  int get hashCode => sim.hashCode;

  /// Converts to Map<String,String>
  Map<String, String> toMap() => {
        'sim': sim,
        'network': network,
        'locale': locale,
      };
}
