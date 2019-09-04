import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/login_screem.dart';
import 'package:loja_virtual/share/models/cart_model.dart';
import 'package:loja_virtual/share/models/user.dart';
import 'package:loja_virtual/share/widgets/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int numProds = model.products.length;
                return Text(
                    "${numProds ?? 0} ${numProds == 1 ? "item" : "itens"}",
                    style: TextStyle(fontSize: 17));
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && User.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!User.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Faça login para adicionar produtos!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 18),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Fazer login",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreem(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map(
                    (cartProduct) {
                      return CartTile(cartProduct);
                    }
                  ).toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
