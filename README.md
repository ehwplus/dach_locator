# dach_locator
[![pub package](https://img.shields.io/pub/v/dach_locator.svg)](https://pub.dartlang.org/packages/dach_locator)
[![Build Status](https://github.com/ehwplus/dach_locator/actions/workflows/tests.yaml/badge.svg?branch=main)](https://github.com/ehwplus/dach_locator/actions/workflows/tests.yaml)

Given a zip code of Germany, Austria or Switzerland the region is resolved.

## Features

* Insert a zip code and get region and country as result (no connection required)
* If possible add countryCode ('DE', 'CH' or 'AT'), otherwise country is automatically resolved.

## Usage

If you want to get the region of a specific country (Austria, Germany, Switzerland), use the
methods `getAustriaRegionCode`, `getGermanRegionCode`, `getSwitzerlandRegionCode`. Internally a
lookup for that zip code is executed for each country.

For ease of use you can instead use method `getRegion`. It returns null (no match) or a `Region` 
instance. Optionally you can pass a countryCode ('DE', 'CH' or 'AT'), then `getRegion` works
identically to `getAustriaRegionCode`, `getGermanRegionCode` or `getSwitzerlandRegionCode`. If
`countryCode` is not passed, the method tries to resolve the country of the zip code automatically.

```dart
  Set<Region> _resolveRegion(String zipCode, {String? countryCode}) {
  if (int.tryParse(zipCode) != null && zipCode.length > 3 && zipCode.length < 6) {
    return getRegion(zipCode, countryCode: countryCode);
  }
  return {};
}
```