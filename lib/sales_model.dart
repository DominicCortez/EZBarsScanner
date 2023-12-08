class Item {
  final String itemquantity;
  final String itemnumber;
  Item({
    required this.itemquantity,
    required this.itemnumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemquantity': itemquantity,
      'itemnumber': itemnumber,
    };
  }
}