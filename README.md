# country_detector

A simple plugin for android and ios that detects a user's country code

## What does it do?

- This plugin detects user's ISO country code based on SIM, Network, and Locale and returns the result as String
- Country Code is all CAPITALIZED. For example, "kr" will be returned as "KR"

## Example

### call plugin
```shell
final _countryDetector = CountryDetector();
```

### isoCountryCode method
- isoCountryCode Method will return a iso country code
- It checks for SIM first and if null, it will check for Network.
- If the value is still null, it will return country code from user's Locale

```shell
try{
  final cc = _countryDetector.isoCountryCode()
} catch (e) {
  print(e);
}
```

### detectAll method
- detectAll method will return a all iso country code detected as AllCountries class

```shell
try{
  final allCodes = _countryDetector.detectAll()
} catch (e) {
  print(e);
}
```
- The detected values can be fetched by calling 'sim', 'network', and 'locale'
-- code from sim => allCodes.sim
-- code from network => allCodes.network
-- code from locale => allCodes.locale


