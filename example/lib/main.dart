import 'package:dach_locator/dach_locator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DACH Locator Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ZipCodeConverterPage(title: 'DACH Locator Demo'),
    );
  }
}

class ZipCodeConverterPage extends StatefulWidget {
  const ZipCodeConverterPage({super.key, required this.title});

  final String title;

  @override
  State<ZipCodeConverterPage> createState() => _ZipCodeConverterPageState();
}

class _ZipCodeConverterPageState extends State<ZipCodeConverterPage> {
  String _zipCode = '';

  Region? _region;

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      _zipCode = controller.text;
      if (int.tryParse(_zipCode) != null && _zipCode.length > 3 && _zipCode.length < 6) {
        final regionMatch = _resolveRegion(_zipCode);
        setState(() {
          _region = regionMatch;
        });
      } else {
        setState(() {
          _region = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                const Text(
                  'Enter ZIP Code:',
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          if (_region?.regionName != null) Text(
            _region!.regionName!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (_region?.regionName != null && _region?.countryName != null) Text(
            _region!.countryName!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Region? _resolveRegion(String zipCode, {String? countryCode}) {
    if (int.tryParse(zipCode) != null && zipCode.length > 3 && zipCode.length < 6) {
      return getRegion(zipCode, countryCode: countryCode);
    }
    return null;
  }
}
