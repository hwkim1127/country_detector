import 'package:country_detector/src/country_detector_method_channel.dart';
import 'package:country_detector/src/country_detector_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:country_detector/country_detector.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCountryDetectorPlatform
    with MockPlatformInterfaceMixin
    implements CountryDetectorPlatform {
  @override
  Future<AllCountries> detectAll() =>
      Future.value(AllCountries(sim: 'US', network: 'US', locale: 'KR'));

  @override
  Future<String> isoCountryCode() => Future.value('US');
}

void main() {
  final CountryDetectorPlatform initialPlatform =
      CountryDetectorPlatform.instance;

  test('$MethodChannelCountryDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCountryDetector>());
  });

  test('isoCountryCode', () async {
    CountryDetector countryDetectorPlugin = CountryDetector();
    MockCountryDetectorPlatform fakePlatform = MockCountryDetectorPlatform();
    CountryDetectorPlatform.instance = fakePlatform;

    expect(await countryDetectorPlugin.isoCountryCode(), 'US');
  });

  test('detectAll', () async {
    CountryDetector countryDetectorPlugin = CountryDetector();
    MockCountryDetectorPlatform fakePlatform = MockCountryDetectorPlatform();
    CountryDetectorPlatform.instance = fakePlatform;

    expect(await countryDetectorPlugin.detectAll(),
        AllCountries(sim: 'US', network: 'US', locale: 'KR'));
  });
}
