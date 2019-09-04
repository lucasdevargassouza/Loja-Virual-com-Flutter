import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/cart_screen.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
      },
    );
  }
}

