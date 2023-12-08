import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'item_details_page.dart';
import 'sales_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanBarcodeResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (_) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _scanBarcode(context),
                child: Text("Scan for inventory"),
              ),
              ElevatedButton(
                onPressed: () => _scanAndRedirect(context),
                child: Text("Scan for sales"),
              ),
              Text("Scanned: $_scanBarcodeResult"),
            ],
          ),
        ),
      ),
    );
  }

  void _scanAndRedirect(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "cancel",
        true,
        ScanMode.BARCODE,
      );
      _navigateToSalesPage(context, barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version";
    }
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

  void _navigateToSalesPage(BuildContext context, String barcodeResult) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SalesPage(scanBarcodeResult: barcodeResult),
      ),
    );
  }

  void _scanBarcode(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "cancel",
        true,
        ScanMode.BARCODE,
      );
      _navigateToItemDetails(context, barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version";
    }
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

  void _navigateToItemDetails(BuildContext context, String barcodeResult) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(scanBarcodeResult: barcodeResult),
      ),
    );
  }
}

