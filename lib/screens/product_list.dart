import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

import '../models/product.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductlistState();
  }
}

class _ProductlistState extends State {
  @override
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  //Girşite boş sayfa gösterir ta ki veri akışı sağlanana kadar
  void initState() {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      this.products = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listeleme"),
      ),
      body: buildProductList(),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.blueAccent,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.deepOrange),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
            ),
          );
        });
  }
}
