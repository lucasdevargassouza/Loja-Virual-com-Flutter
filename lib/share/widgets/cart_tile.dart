import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/share/models/cart_model.dart';
import 'package:loja_virtual/share/models/cart_product.dart';
import 'package:loja_virtual/share/models/product.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();

      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.product.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cartProduct.product.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Text(
                    "Tamanho: ${cartProduct.size}",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$: ${cartProduct.product.price.toStringAsFixed(2)}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: cartProduct.quantity <= 1
                            ? null
                            : () {
                                CartModel.of(context).decCartItem(cartProduct);
                              },
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CartModel.of(context).incCartItem(cartProduct);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Remover",
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.product == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(cartProduct.category)
                  .collection("items")
                  .document(cartProduct.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.product = Product.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
