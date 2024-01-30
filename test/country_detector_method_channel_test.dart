import 'package:country_detector/src/country_detector.dart';
import 'package:country_detector/src/country_detector_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCountryDetector platform = MethodChannelCountryDetector();
  const MethodChannel channel = MethodChannel('country_detector');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'isoCountryCode':
            return 'US';
          case 'detectAll':
            return {'sim': 'US', 'network': 'US', 'locale': 'KR'};
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isoCountryCode', () async {
    expect(await platform.isoCountryCode(), 'US');
  });

  test('detectAll', () async {
    expect(await platform.detectAll(),
        AllCountries(sim: 'US', network: 'US', locale: 'KR'));
  });
}
