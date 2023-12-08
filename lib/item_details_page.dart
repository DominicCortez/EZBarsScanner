// item_details_page.dart
import 'package:flutter/material.dart';
import 'item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemDetailsPage extends StatefulWidget {
  final String scanBarcodeResult;

  const ItemDetailsPage({Key? key, required this.scanBarcodeResult}) : super(key: key);


  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController(text: widget.scanBarcodeResult);
  }

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
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Item Category'),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Item Description'),
            ),
            TextFormField(
              controller: numberController,
              enabled: false,
              decoration: InputDecoration(labelText: 'Item Number'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Item Quantity'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Item Price'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Create an instance of the Item class
                Item newItem = Item(
                  itemcategory: categoryController.text,
                  itemname: nameController.text,
                  itemdescription: descriptionController.text,
                  itemnumber: numberController.text,
                  itemquantity: quantityController.text,
                  itemprice: priceController.text,
                );

                Map<String, dynamic> jsonData = newItem.toJson();

                // Define your API endpoint
                String apiEndpoint = 'http://ec2-3-27-189-2.ap-southeast-2.compute.amazonaws.com/api/inventory';

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
