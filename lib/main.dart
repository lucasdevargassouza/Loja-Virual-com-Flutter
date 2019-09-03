import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/home.dart';
import 'package:loja_virtual/share/models/cart_model.dart';
import 'package:loja_virtual/share/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
      model: User(),
      child: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'Loja virtual',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: Home(),
            ),
          );
        },
      ),
    );
  }
}
