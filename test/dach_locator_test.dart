import 'package:flutter_test/flutter_test.dart';

import 'package:dach_locator/dach_locator.dart';

void main() {
  group('ZIP to Region', () {
    test('PLZ 68519 Viernheim -> Hessen (DE)', () {
      const plz = '68519';
      expect(getGermanRegionCode(plz), {GermanRegion.hessen});
    });

    test('PLZ 69469 Weinheim -> Baden Württemberg (DE)', () {
      const plz = '69469';
      expect(getGermanRegionCode(plz), {GermanRegion.badenWuerttemberg});
    });

    test('PLZ 07919 Pausa-Mühltroff -> Thüringen/Sachsen (DE)', () {
      const plz = '07919';
      expect(getGermanRegionCode(plz),
          {GermanRegion.thueringen, GermanRegion.sachsen});
    });

    test('PLZ 87491 Jungholz -> Tirol (AT)', () {
      const plz = '87491';
      expect(getAustriaRegionCode(plz), {AustriaRegion.tirol});
    });

    test('PLZ 5745 -> SwitzerlandRegion.Aargau', () {
      const plz = '5745';
      expect(getSwitzerlandRegionCode(plz), {SwitzerlandRegion.aargau});
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
