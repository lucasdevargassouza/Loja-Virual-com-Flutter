import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/cart_screen.dart';
import 'package:loja_virtual/pages/home/login_screem.dart';
import 'package:loja_virtual/share/models/cart_model.dart';
import 'package:loja_virtual/share/models/cart_product.dart';
import 'package:loja_virtual/share/models/product.dart';
import 'package:loja_virtual/share/models/user.dart';
import 'package:loja_virtual/share/widgets/cart_button.dart';

class ProductScreem extends StatefulWidget {
  final Product product;

  ProductScreem(this.product);

  @override
  _ProductScreemState createState() => _ProductScreemState(product);
}

class _ProductScreemState extends State<ProductScreem> {
  final Product product;
  var size;

  _ProductScreemState(this.product);

  @override
  Widget build(BuildContext context) {
    final pmColor = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: CartButton(),
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: pmColor,
              autoplay: false,
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$: " + product.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: pmColor,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map(
                      (s) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              size = s;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color:
                                      s == size ? pmColor : Colors.grey[500]),
                            ),
                            alignment: Alignment.center,
                            child: Text(s,
                                style: TextStyle(
                                    color:
                                        s == size ? pmColor : Colors.grey[500],
                                    fontWeight: s == size
                                        ? FontWeight.bold
                                        : FontWeight.normal)),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: size != null ? () {
                      if (User.of(context).isLoggedIn()) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.product = product;
                        
                        CartModel.of(context).addCartItem(cartProduct);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));

                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreem()));
                      }
                    } : null,
                    color: pmColor,
                    textColor: Colors.white,
                    child: Text(User.of(context).isLoggedIn() ? "Adicionar ao carrinho" : "Entre para comprar",
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
