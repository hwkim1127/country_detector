import 'package:flutter/material.dart';

import 'package:country_detector/country_detector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _countryDetector = CountryDetector();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country Code Detector Example'),
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            FutureBuilder<String?>(
                future: _countryDetector.isoCountryCode(),
                builder: (_, future) {
                  if (future.connectionState == ConnectionState.done) {
                    return Text('isoCode : ${future.data ?? ''}\n');
                  }
                  if (future.hasError) {
                    return const Text('fetching iso country code failed\n');
                  }
                  return const Text('Fetching iso country code...\n');
                }),
            FutureBuilder<AllCountries>(
                future: _countryDetector.detectAll(),
                builder: (_, future) {
                  if (future.connectionState == ConnectionState.done) {
                    final allCodes = future.data ?? AllCountries();
                    String resultStr = '';
                    for (final code in allCodes.toMap().entries) {
                      resultStr += '${code.key} : ${code.value}\n';
                    }
                    return Text('$resultStr\n');
                  }
                  if (future.hasError) {
                    return const Text('fetching all country code failed\n');
                  }
                  return const Text('Fetching all country code...\n');
                }),
          ]),
        ),
      ),
    );
  }
}
