import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/share/models/product.dart';

class CartProduct {
  String cid;

  String category;
  String pid;

  int quantity;
  String size;

  Product product;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": product.toResumedMap(),
    };
  }
}