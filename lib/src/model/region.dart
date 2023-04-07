import 'country.dart';

class Region {
  const Region({
    required this.country,
    this.germanRegion,
    this.austriaRegion,
    this.switzerlandRegion,
  });

  final Country? country;

  final GermanRegion? germanRegion;

  final AustriaRegion? austriaRegion;

  final SwitzerlandRegion? switzerlandRegion;

  String? get countryCode {
    switch (country) {
      case Country.germany:
        return 'DE';
      case Country.austria:
        return 'AT';
      case Country.switzerland:
        return 'CH';
      default:
        return null;
    }
  }

  String? get countryName {
    switch (country) {
      case Country.germany:
        return 'Germany';
      case Country.austria:
        return 'Austria';
      case Country.switzerland:
        return 'Switzerland';
      default:
        return null;
    }
  }

  String? get regionName {
    return _getRegionName(
        germanRegion?.name ?? austriaRegion?.name ?? switzerlandRegion?.name);
  }

  String? get regionCode {
    return germanRegion?.regionCode ??
        austriaRegion?.regionCode ??
        switzerlandRegion?.regionCode;
  }

  String _getRegionName(String? enumName) {
    if (enumName == null) {
      return '';
    }

    if (enumName == SwitzerlandRegion.appenzellARh.name) {
      return 'Appenzell Ausserrhoden';
    }
    if (enumName == SwitzerlandRegion.appenzellIRh.name) {
      return 'Appenzell Innerrhoden';
    }

    String addSpaces = enumName.replaceAllMapped(RegExp('[A-Z]'), (match) {
      return ' ${match.group(0)}';
    });
    final firstUpperCase = addSpaces.substring(0, 1).toUpperCase() +
        addSpaces.substring(1, addSpaces.length);
    final List<String> words = firstUpperCase.split(' ');

    final sb = StringBuffer();
    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      sb.write(word);
      if (i < words.length - 1) {
        sb.write('-');
      }
    }
    return sb
        .toString()
        .replaceAll('ae', 'ä')
        .replaceAll('ue', 'ü')
        .replaceAll('oe', 'ö');
  }
}

enum GermanRegion {
  badenWuerttemberg,
  bayern,
  berlin,
  brandenburg,
  bremen,
  hamburg,
  hessen,
  mecklenburgVorpommern,
  niedersachsen,
  nordrheinWestfalen,
  rheinlandPfalz,
  saarland,
  sachsen,
  sachsenAnhalt,
  schleswigHolstein,
  thueringen;

  String get regionCode {
    switch (this) {
      case GermanRegion.badenWuerttemberg:
        return 'BW';
      case GermanRegion.bayern:
        return 'BY';
      case GermanRegion.berlin:
        return 'BE';
      case GermanRegion.brandenburg:
        return 'BB';
      case GermanRegion.bremen:
        return 'HB';
      case GermanRegion.hamburg:
        return 'HH';
      case GermanRegion.hessen:
        return 'HE';
      case GermanRegion.mecklenburgVorpommern:
        return 'MV';
      case GermanRegion.niedersachsen:
        return 'NI';
      case GermanRegion.nordrheinWestfalen:
        return 'NW';
      case GermanRegion.rheinlandPfalz:
        return 'RP';
      case GermanRegion.saarland:
        return 'SL';
      case GermanRegion.sachsen:
        return 'SN';
      case GermanRegion.sachsenAnhalt:
        return 'ST';
      case GermanRegion.schleswigHolstein:
        return 'SH';
      case GermanRegion.thueringen:
        return 'TH';
    }
  }
}

enum AustriaRegion {
  burgenland, // 1
  kaernten, // 2
  niederoesterreich, // 3
  oberoesterreich, // 4
  salzburg, // 5
  steiermark, // 6
  tirol, // 7
  vorarlberg, // 8
  wien; // 9

  String get regionCode {
    switch (this) {
      case AustriaRegion.burgenland:
        return 'AT-1';
      case AustriaRegion.kaernten:
        return 'AT-2';
      case AustriaRegion.niederoesterreich:
        return 'AT-3';
      case AustriaRegion.oberoesterreich:
        return 'AT-4';
      case AustriaRegion.salzburg:
        return 'AT-5';
      case AustriaRegion.steiermark:
        return 'AT-6';
      case AustriaRegion.tirol:
        return 'AT-7';
      case AustriaRegion.vorarlberg:
        return 'AT-8';
      case AustriaRegion.wien:
        return 'AT-9';
    }
  }
}

/// Schweizer Kantone
enum SwitzerlandRegion {
  zuerich, // (1)
  bern, // (2)
  luzern, // (3)
  uri, // (4)
  schwyz, // (5)
  obwalden, // (6)
  nidwalden, // (7)
  glarus, // (8)
  zug, // (9)
  freiburg, // (10)
  solothurn, // (11)
  baselStadt, // (12)
  baselLandschaft, // (13)
  schaffhausen, // (14)
  appenzellARh, // (15)
  appenzellIRh, // (16)
  sanktGallen, // (17)
  graubuenden, // (18)
  aargau, // (19)
  thurgau, // (20)
  tessin, // (21)
  waadt, // (22)
  wallis, // (23)
  neuenburg, // (24)
  genf, // (25)
  jura; // (26)

  String get regionCode {
    // Aargau (AG), Bern (BE), Fribourg / Freiburg (FR), Genève / Genf (GE),
    // Glarus (GL), Graubünden (GR), Jura (JU), Luzern (LU),
    // Neuchâtel / Neuenburg (NE), St.Gallen (SG), Schaffhausen (SH),
    // Schwyz (SZ), Solothurn (SO), Thurgau (TG), Ticino / Tessin (TI),
    // Uri (UR), Valais / Wallis (VS), Vaud / Waadt (VD), Zug (ZG), Zürich (ZH)
    switch (this) {
      case SwitzerlandRegion.zuerich:
        return 'ZH';
      case SwitzerlandRegion.bern:
        return 'BE';
      case SwitzerlandRegion.luzern:
        return 'LU';
      case SwitzerlandRegion.uri:
        return 'UR';
      case SwitzerlandRegion.schwyz:
        return 'SZ';
      case SwitzerlandRegion.obwalden:
        return 'OW';
      case SwitzerlandRegion.nidwalden:
        return 'NW';
      case SwitzerlandRegion.glarus:
        return 'GL';
      case SwitzerlandRegion.zug:
        return 'ZG';
      case SwitzerlandRegion.freiburg:
        return 'FR';
      case SwitzerlandRegion.solothurn:
        return 'SO';
      case SwitzerlandRegion.baselStadt:
        return 'BS';
      case SwitzerlandRegion.baselLandschaft:
        return 'BL';
      case SwitzerlandRegion.schaffhausen:
        return 'SH';
      case SwitzerlandRegion.appenzellARh:
        return 'AR';
      case SwitzerlandRegion.appenzellIRh:
        return 'AI';
      case SwitzerlandRegion.sanktGallen:
        return 'SG';
      case SwitzerlandRegion.graubuenden:
        return 'GR';
      case SwitzerlandRegion.aargau:
        return 'AG';
      case SwitzerlandRegion.thurgau:
        return 'TG';
      case SwitzerlandRegion.tessin:
        return 'TI';
      case SwitzerlandRegion.waadt:
        return 'VD';
      case SwitzerlandRegion.wallis:
        return 'VS';
      case SwitzerlandRegion.neuenburg:
        return 'NE';
      case SwitzerlandRegion.genf:
        return 'GE';
      case SwitzerlandRegion.jura:
        return 'JU';
    }
  }
}
