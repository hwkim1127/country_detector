# country_detector

A simple plugin for android and ios that detects a user's country code

## What does it do?

- This plugin detects user's ISO country code based on SIM, Network(only for android), and Locale and returns the result as String
- Country Code is all CAPITALIZED. For example, "kr" will be returned as "KR"

## Example

### call plugin
```shell
final _countryDetector = CountryDetector();
```

### isoCountryCode
- isoCountryCode Method will return a iso country code
- first from SIM and if null, it will check for Network(Android only), 
and if also null, it will return locale country code

```shell
try{
  final cc = _countryDetector.isoCountryCode()
} catch (e) {
  print(e);
}
```

### detectAll
- detectAll Method will return a all iso country code detected as AllCountries class

```shell
try{
  final allCodes = _countryDetector.detectAll()
  final simCountryCode = allCodes.sim;
  final networkCountryCode = allCodes.network; // not supported for iOS
  final localeCountryCode = allCodes.locale;
} catch (e) {
  print(e);
}
```


