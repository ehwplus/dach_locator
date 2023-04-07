import 'dart:ui' as ui;

import 'package:dach_locator/dach_locator.dart';

Region? getRegion(String regionCode, {String? countryCode}) {
  final deviceCountryCode = countryCode ?? ui.window.locale.countryCode;

  if (regionCode.length == 5 && (countryCode == null || deviceCountryCode == 'DE')) {
    final germanRegion = getGermanRegionCode(regionCode);
    if (germanRegion != null) {
      return Region(
        country: Country.germany,
        germanRegion: germanRegion,
      );
    }
  }

  if ((regionCode.length == 4 || regionCode.length == 5) && (countryCode == null || deviceCountryCode == 'AT')) {
    final austriaRegion = getAustriaRegionCode(regionCode);
    if (austriaRegion != null) {
      return Region(
        country: Country.austria,
        austriaRegion: austriaRegion,
      );
    }
  }

  if (regionCode.length == 4 && (countryCode == null || deviceCountryCode == 'CH')) {
    final switzerlandRegion = getSwitzerlandRegionCode(regionCode);
    if (switzerlandRegion != null) {
      return Region(
        country: Country.switzerland,
        switzerlandRegion: switzerlandRegion,
      );
    }
  }

  if (['DE', 'CH', 'AT'].contains(deviceCountryCode)) {
    Country? country;
    if (deviceCountryCode == 'DE') {
      country = Country.germany;
    } else if (deviceCountryCode == 'AT') {
      country = Country.austria;
    } else if (deviceCountryCode == 'CH') {
      country = Country.switzerland;
    }
    return Region(
      country: country,
    );
  }

  return null;
}

/// Note: There are cities with same postal code but different region, e.g.
/// Pausa-Mühltroff (Sachsen) and Kirschkau (Thüringen) with postal code "07919".
GermanRegion? getGermanRegionCode(String plz) {
  assert(plz.length == 5, 'German PLZ should have length 5.');

  final code = int.parse(plz);

  final Map<GermanRegion, Set<String>> map = {
    GermanRegion.sachsen: {'01001-01936', '02601-02999', '04001-04579',
      '04641-04889', '07919-07919', '07951-07951', '07952-07952', '07982-07982',
      '07985-07985', '08001-09669',
    },
    GermanRegion.brandenburg: {'01941-01998', '03001-03253', '04891-04938',
      '14401-14715', '14723-16949', '17258-17258', '17261-17291', '17309-17309',
      '17321-17321', '17326-17326', '17335-17335', '17337-17337', '19307-19357',
    },
    GermanRegion.thueringen: {'04581-04639', '06551-06578', '07301-07919',
      '07919-07919', '07920-07950', '07952-07952', '07953-07980', '07985-07985',
      '07985-07989', '36401-36469', '37301-37359', '96501-96529', '98501-99998'
    },
    GermanRegion.sachsenAnhalt: {'06001-06548', '06601-06928', '14715-14715',
      '29401-29416', '38481-38489', '38801-39649',
    },
    GermanRegion.berlin: {'10001-14330'},
    GermanRegion.mecklenburgVorpommern: {'17001-17256', '17258-17259',
      '17301-17309', '17309-17321', '17321-17322', '17328-17331', '17335-17335',
      '17337-19260', '19273-19273', '19273-19306', '19357-19417', '23921-23999',
    },
    GermanRegion.niedersachsen: {'19271-19273', '21202-21449', '21522-21522',
      '21601-21789', '26001-27478', '27607-27809', '28784-29399', '29431-31868',
      '34331-34353', '34355-34355', '37001-37194', '37197-37199', '37401-37649',
      '37689-37691', '37697-38479', '38501-38729', '48442-48465', '48478-48480',
      '48486-48488', '48497-48531', '49001-49459', '49551-49849',
    },
    GermanRegion.hamburg: {'20001-21037', '21039-21170', '22001-22113',
      '22115-22143', '22145-22145', '22147-22786', '27499-27499',
    },
    GermanRegion.schleswigHolstein: {'21039-21039', '21451-21521',
      '21524-21529', '22113-22113', '22145-22145', '22801-23919', '24001-25999',
      '27483-27498',
    },
    GermanRegion.bremen: {'27501-27580', '28001-28779'},
    GermanRegion.nordrheinWestfalen: {'32001-33829', '34401-34439',
      '37651-37688', '37692-37696', '40001-48432', '48466-48477', '48481-48485',
      '48489-48496', '48541-48739', '49461-49549', '50101-51597', '51601-53359',
      '53581-53604', '53621-53949', '57001-57489', '58001-59966', '59969-59969',
    },
    GermanRegion.hessen: {'34001-34329', '34355-34355', '34356-34399',
      '34441-36399', '37194-37195', '37201-37299', '55240-55252', '59969-59969',
      '60001-63699', '63776-63776', '64201-64753', '64754-65326', '65327-65391',
      '65392-65556', '65583-65620', '65627-65627', '65701-65936', '68501-68519',
      '68601-68649', '69235-69239', '69430-69431', '69434-69434', '69479-69488',
      '69503-69509', '69515-69518',
    },
    GermanRegion.rheinlandPfalz: {'51598-51598', '53401-53579', '53614-53619',
      '54181-55239', '55253-56869', '57501-57648', '65326-65326', '65391-65391',
      '65558-65582', '65621-65626', '65629-65629', '66461-66509', '66841-67829',
      '76711-76891',
    },
    GermanRegion.bayern: {'63701-63774', '63776-63928', '63930-63939',
      '74594-74594', '80001-87490', '87493-87561', '87571-87789', '88101-88146',
      '88147-88179', '89081-89081', '89087-89087', '89201-89449', '90001-96489',
      '97001-97859', '97888-97892', '97896-97896', '97901-97909',
    },
    GermanRegion.badenWuerttemberg: {'63928-63928', '64754-64754 ',
      '68001-68312', '68520-68549', '68701-69234', '69240-69429', '69434-69434',
      '69435-69469', '69489-69502', '69510-69514', '70001-74592', '74594-76709',
      '77601-79879', '88001-88099', '88147-88147', '88181-89079', '89081-89085',
      '89090-89198', '89501-89619', '97861-97877', '97893-97896', '97897-97900',
      '97911-97999',
    },
    GermanRegion.saarland: {'66001-66459', '66511-66839'},
  };

  for (final region in map.keys) {
    for (final value in map[region]!) {
      final pair = value.split('-');
      if (code >= int.parse(pair[0]) && code <= int.parse(pair[1])) {
        return region;
      }
    }
  }

  return null;
}

AustriaRegion? getAustriaRegionCode(String plz) {
  assert(plz.length == 5 || plz.length == 4, 'Austria PLZ should have length 4 or 5.');

  final code = int.parse(plz);
  if (plz.length == 5) {
    final Map<AustriaRegion, Set<String>> map = {
      AustriaRegion.tirol: {
        '87491-87491', // Jungholz
      },
      AustriaRegion.vorarlberg: {
        '87567-87567', // Riezlern
        '87568-87568', // Hirschegg
        '87569-87569', // Mittelberg
      },
    };

    for (final region in map.keys) {
      for (final value in map[region]!) {
        final pair = value.split('-');
        if (code >= int.parse(pair[0]) && code <= int.parse(pair[1])) {
          return region;
        }
      }
    }
  } else {
    /*
    1xxx – Wien (auch teilweise für benachbarte Orte in Niederösterreich)
    2xxx – östliches und südliches Niederösterreich, auch teilweise für Nordburgenland
    3xxx – westliches und nördliches Niederösterreich, auch kleine Teile südöstliches Oberösterreich
    4xxx – Oberösterreich und kleine Teile westliches Niederösterreich
    5xxx – Salzburg und westliches Oberösterreich
    6xxx – Nordtirol und Vorarlberg
    7xxx – Burgenland, soweit es nicht unter 2xxx oder 8xxx fällt
    8xxx – Steiermark, Teile des Bezirks Jennersdorf im Südburgenland
    9xxx – Kärnten und Osttirol
     */

    final Map<AustriaRegion, Set<String>> map = {
      AustriaRegion.wien: {
        '1010-1230',
      },
      AustriaRegion.niederoesterreich: {
        '2000-2412', '2413-2413', '2431-2441', '2443-2454', '2460-2472',
        '2481-2483', '2486-2490', '2492-3332', '3340-3972', '4300-4300',
        '4303-4303', '4392-4392', '4431-4441', '4482-4482',
      },
      AustriaRegion.oberoesterreich: {
        '3334-3335', '4020-4294', '4310-4391', '4400-4421', '4443-4481',
        '4483-4984', '5120-5145', '5163-5163', '5166-5166', '5211-5280',
        '5310-5310', '5360-5360',
      },
      AustriaRegion.burgenland: {
        '2413-2413', '2421-2425', '2443-2443', '2460-2460', '2473-2475',
        '2485-2485', '2491-2491', '7000-7572', '8291-8291', '8292-8292',
        '8293-8293', '8380-8385',
      },
      AustriaRegion.salzburg: {
        '5020-5114', '5151-5162', '5163-5165', '5201-5205', '5300-5303',
        '5321-5350', '5400-5771',
      },
      AustriaRegion.tirol: {
        '6020-6691', '9782-9782', '9900-9992',
      },
      AustriaRegion.vorarlberg: {
        '6700-6991',
      },
      AustriaRegion.steiermark: {
        '8010-8283', '8291-8291', '8292-8292', '8294-8362', '8401-8993'
      },
      AustriaRegion.kaernten: {
        '9020-9781', '9800-9872'
      },
    };

    for (final region in map.keys) {
      for (final value in map[region]!) {
        final pair = value.split('-');
        if (code >= int.parse(pair[0]) && code <= int.parse(pair[1])) {
          return region;
        }
      }
    }
  }

  return null;
}

SwitzerlandRegion? getSwitzerlandRegionCode(String plz) {
  assert(plz.length == 4, 'Switzerland PLZ should have length 4.');

  final code = int.parse(plz);

  if ({
    '6911', // Campione d'Italia
    '8238', // Büsingen in DE
  }.contains(plz)) {
    return null;
  }

  // source: https://postleitzahlenschweiz.ch/tabelle/
  final Map<SwitzerlandRegion, Set<String>> map = {
    SwitzerlandRegion.waadt: {
      '1000-1197', '1260-1279', '1290-1291', '1295-1297', '1299-1409',
      '1410-1464', '1509-1526', '1530-1530', '1534-1538', '1543-1543',
      '1545-1552', '1554-1562', '1565-1565', '1580-1582', '1584-1589',
      '1595-1607', '1608-1608', '1610-1610', '1612-1613', '1658-1660',
      '1682-1683', '1787-1787', '1800-1867', '1880-1885', '1892-1892',
    },
    SwitzerlandRegion.genf: {
      '1200-1258', '1281-1290', '1292-1294', '1298-1298',
    },
    SwitzerlandRegion.freiburg: {
      '1410-1410', '1468-1489', '1527-1529', '1532-1534', '1541-1542',
      '1544-1544', '1553-1553', '1563-1565', '1566-1568', '1583-1583',
      '1608-1608', '1609-1609', '1611-1611', '1614-1656', '1658-1681',
      '1684-1737', '1740-1787', '1788-1796', '3175-3175', '3178-3178',
      '3182-3182', '3184-3186', '3206-3206', '3210-3216', '3280-3280',
      '3284-3286',
    },
    SwitzerlandRegion.bern: {
      '1595-1595', '1657-1657', '1738-1738', '1797-1797', '2333-2333',
      '2500-2520', '2532-2538', '2542-2543', '2552-2713', '2715-2717',
      '2720-2762', '2827-2827', '3000-3174', '3176-3177', '3179-3179',
      '3183-3183', '3202-3206', '3207-3208', '3225-3252', '3255-3274',
      '3282-3283', '3292-3306', '3308-3800', '3803-3864', '4536-4539',
      '4564-4564', '4704-4704', '4900-4914', '4916-4955', '6083-6086',
      '6197-6197',
    },
    SwitzerlandRegion.wallis: {
      '1868-1875', '1890-1891', '1893-1997', '3801-3801', '3900-3999',
    },
    SwitzerlandRegion.neuenburg: {
      '2000-2325','2400-2416', '2523-2525',
    },
    SwitzerlandRegion.jura: {
      '2336-2364', '2714-2714', '2718-2718', '2800-2813', '2822-2826',
      '2827-2954',
    },
    SwitzerlandRegion.solothurn: {
      '2540-2540', '2544-2545', '3253-3254', '3307-3307', '4108-4116',
      '4118-4118', '4143-4143', '4145-4146', '4204-4206', '4208-4208',
      '4226-4234', '4245-4245', '4247-4252', '4412-4413', '4421-4421',
      '4468-4468', '4500-4535', '4542-4563', '4564-4658', '4702-4703',
      '4710-4719', '5012-5015', '5746-5746',
    },
    SwitzerlandRegion.baselLandschaft: {
      '2814-2814', '4101-4107', '4117-4117', '4123-4124', '4127-4142',
      '4144-4144', '4147-4203', '4207-4207', '4222-4225', '4242-4244',
      '4246-4246', '4253-4302', '4304-4304', '4402-4411', '4414-4419',
      '4422-4467', '4469-4497',
    },
    SwitzerlandRegion.baselStadt: {
      '4000-4059', '4125-4126',
    },
    SwitzerlandRegion.aargau: {
      '4303-4303', '4305-4334', '4663-4665', '4800-4805', '4812-4856',
      '5000-5004', '5017-5734', '5736-5745', '8109-8109', '8905-8905',
      '8916-8919', '8956-8967',
    },
    SwitzerlandRegion.luzern: {
      '4806-4806', '4915-4915', '5735-5735', '6000-6010', '6012-6048',
      '6102-6196', '6203-6295', '6344-6344', '6353-6356', '6404-6404',
    },
    SwitzerlandRegion.obwalden: {
      '6010-6010', '6053-6078', '6388-6390',
    },
    SwitzerlandRegion.nidwalden: {
      '6052-6052', '6362-6376', '6382-6387',
    },
    SwitzerlandRegion.zug: {
      '6300-6343', '6345-6345',
    },
    SwitzerlandRegion.uri: {
      '6377-6377', '6441-6441', '6452-6493', '8751-8751',
    },
    SwitzerlandRegion.schwyz: {
      '6402-6403', '6405-6440', '6442-6452', '8640-8640',
      '8806-8808', '8832-8832', '8834-8864',
    },
    SwitzerlandRegion.tessin: {
      '6500-6533', '6571-6900', '6912-6999',
    },
    SwitzerlandRegion.graubuenden: {
      '6534-6565', '7000-7307', '7402-7748',
    },
    SwitzerlandRegion.sanktGallen: {
      '7310-7326', '8638-8638', '8640-8640', '8645-8646',
      '8715-8739', '8872-8873', '8877-8898', '9000-9034',
      '9036-9036', '9113-9212', '9230-9305', '9308-9313',
      '9323-9323', '9327-9404', '9422-9425', '9430-9437',
      '9442-9479', '9500-9500', '9512-9512', '9523-9527',
      '9533-9534', '9536-9536', '9552-9552', '9601-9658',
    },
    SwitzerlandRegion.zuerich: {
      '8000-8108', '8112-8197', '8212-8212', '8245-8248',
      '8302-8354', '8400-8453', '8457-8499', '8523-8523',
      '8542-8545', '8546-8546', '8548-8548', '8600-8637',
      '8639-8639', '8700-8714', '8800-8805', '8810-8825',
      '8833-8833', '8902-8904', '8906-8915', '8925-8955',
    },
    SwitzerlandRegion.schaffhausen: {
      '8200-8212', '8213-8236', '8239-8243', '8260-8263',
      '8454-8455',
    },
    SwitzerlandRegion.thurgau: {
      '8252-8259', '8264-8280', '8355-8376', '8500-8522',
      '8524-8537', '8546-8546', '8547-8547', '8552-8599',
      '9213-9225', '9306-9306', '9314-9322', '9325-9326',
      '9502-9508', '9514-9517', '9532-9532', '9535-9535',
      '9542-9548', '9553-9573',
    },
    SwitzerlandRegion.glarus: {
      '8750-8750', '8752-8784', '8865-8868', '8874-8874',
    },
    SwitzerlandRegion.appenzellARh: {
      '9035-9035', '9037-9044', '9052-9053', '9055-9056',
      '9062-9107', '9112-9112', '9405-9411', '9414-9414',
      '9426-9428', '9442-9442',
    },
    SwitzerlandRegion.appenzellIRh: {
      '9050-9050', '9054-9054', '9057-9057', '9108-9108',
      '9413-9413',
    }
  };

  for (final region in map.keys) {
    for (final value in map[region]!) {
      final pair = value.split('-');
      if (code >= int.parse(pair[0]) && code <= int.parse(pair[1])) {
        return region;
      }
    }
  }

  return null;
}