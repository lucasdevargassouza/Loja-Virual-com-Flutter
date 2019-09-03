import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/share/models/cart_product.dart';
import 'package:loja_virtual/share/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  User user;
  List<CartProduct> products = [];

  CartModel(this.user);

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);


  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(user.firabaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firabaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();

    products.add(cartProduct);
    notifyListeners();
  }
}
