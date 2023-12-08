class Item {
  final String itemcategory;
  final String itemname;
  final String itemdescription;
  final String itemnumber;
  final String itemquantity;
  final String itemprice;

  Item({
    required this.itemcategory,
    required this.itemname,
    required this.itemdescription,
    required this.itemnumber,
    required this.itemquantity,
    required this.itemprice,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemcategory': itemcategory,
      'itemname': itemname,
      'itemdescription': itemdescription,
      'itemnumber': itemnumber,
      'itemquantity': itemquantity,
      'itemprice': itemprice,
    };
  }
}