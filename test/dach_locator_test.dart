import 'package:flutter_test/flutter_test.dart';

import 'package:dach_locator/dach_locator.dart';

void main() {
  group('ZIP to Region', () {
    test('PLZ 68519 Viernheim -> GermanRegion.Hessen', () {
      const plzViernheim = '68519';
      expect(getGermanRegionCode(plzViernheim), GermanRegion.hessen);
    });

    test('PLZ 69469 Weinheim -> GermanRegion.BadenWuerttemberg', () {
      const plzWeinheim = '69469';
      expect(getGermanRegionCode(plzWeinheim), GermanRegion.badenWuerttemberg);
    });

    test('PLZ 5745 -> SwitzerlandRegion.Aargau', () {
      const plzAargau = '5745';
      expect(getSwitzerlandRegionCode(plzAargau), SwitzerlandRegion.aargau);
    });
  });

  group('Region name', () {
    test('Region name Hessen', () {
      const region = Region(
        country: Country.germany,
        germanRegion: GermanRegion.hessen,
      );
      expect(region.regionName, 'Hessen');
    });

    test('Region name Baden-Württemberg', () {
      const region = Region(
        country: Country.germany,
        germanRegion: GermanRegion.badenWuerttemberg,
      );
      expect(region.regionName, 'Baden-Württemberg');
    });

    test('Region name Zürich', () {
      const region = Region(
        country: Country.switzerland,
        switzerlandRegion: SwitzerlandRegion.zuerich,
      );
      expect(region.regionName, 'Zürich');
    });

    test('Region name Basel-Landschaft', () {
      const region = Region(
        country: Country.switzerland,
        switzerlandRegion: SwitzerlandRegion.baselLandschaft,
      );
      expect(region.regionName, 'Basel-Landschaft');
    });

    test('Region name Appenzell ARh', () {
      const region = Region(
        country: Country.switzerland,
        switzerlandRegion: SwitzerlandRegion.appenzellARh,
      );
      expect(region.regionName, 'Appenzell Ausserrhoden');
    });
  });
}
