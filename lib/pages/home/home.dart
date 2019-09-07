import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/tabs/home_tab.dart';
import 'package:loja_virtual/pages/home/tabs/orders_tab.dart';
import 'package:loja_virtual/pages/home/tabs/places_tab.dart';
import 'package:loja_virtual/pages/home/tabs/products_tab.dart';
import 'package:loja_virtual/share/widgets/cart_button.dart';
import 'package:loja_virtual/share/widgets/custom_drawer.dart';

class Home extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(_pageController),
          body: HomeTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
            backgroundColor: Colors.grey,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
            backgroundColor: Colors.grey,
          ),
          drawer: CustomDrawer(_pageController),
          body: PlacesTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Pedidos"),
            centerTitle: true,
            backgroundColor: Colors.grey,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab(),
        ),
      ],
    );
  }
}
