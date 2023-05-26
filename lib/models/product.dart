class Product {
  late int id;
  late String name;
  late String description;
  late double unitPrice;

  Product(
      {required this.name, required this.description, required this.unitPrice});
  Product.withId(
      {required this.id,
      required this.name,
      required this.description,
      required this.unitPrice});

  //gelen ürünü map e dönüştürüyor
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
  }

  Product.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"])!;
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"])!;
  }
}
