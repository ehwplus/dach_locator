Given a zip code of Germany, Austria or Switzerland the region is resolved.

## Features

* Insert a zip code and get region and country as result
* If possible add countryCode ('DE', 'CH' or 'AT'), otherwise country is automatically resolved.

## Usage

```dart
Region? resolveRegion(String zipCode, {String? countryCode}) {
  if (int.tryParse(zipCode) != null && zipCode.length > 3 && zipCode.length < 6) {
    return getRegion(zipCode, countryCode: countryCode);
  }
  return null;
}
```
