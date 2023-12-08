// item_details_page.dart
import 'package:flutter/material.dart';
import 'sales_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalesPage extends StatefulWidget {
  final String scanBarcodeResult;

  const SalesPage({Key? key, required this.scanBarcodeResult}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scanned Item Number: ${widget.scanBarcodeResult}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Item Quantity'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Validate if quantity is not empty
                if (quantityController.text.isEmpty) {
                  // Show an error message or handle it as you prefer
                  return;
                }

                // Create an instance of the Item class with the scanned item number and quantity
                Item newItem = Item(
                  itemnumber: widget.scanBarcodeResult,
                  itemquantity: quantityController.text,
                );

                Map<String, dynamic> jsonData = newItem.toJson();

                // Define your API endpoint
                String apiEndpoint = 'http://ec2-3-27-189-2.ap-southeast-2.compute.amazonaws.com/api/merger';

                try {
                  // Send HTTP POST request
                  var response = await http.post(
                    Uri.parse(apiEndpoint),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(jsonData),
                  );

                  // Check if the request was successful (status code 2xx)
                  if (response.statusCode >= 200 && response.statusCode < 300) {
                    // Handle success, you can print the response for now
                    print('Response: ${response.body}');

                    // Navigate back to the previous screen or any other screen
                    Navigator.pop(context);
                  } else {
                    // Handle errors, you can print the response for now
                    print('Error: ${response.statusCode}, ${response.body}');
                    // You might want to show an error message to the user
                  }
                } catch (error) {
                  // Handle network errors
                  print('Error: $error');
                  // You might want to show an error message to the user
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
