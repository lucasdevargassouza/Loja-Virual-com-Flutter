import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/share/models/product.dart';

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
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(s,
                                style: TextStyle(
                                  color: s == size ? pmColor : Colors.grey[500],
                                  fontWeight: s == size ? FontWeight.bold : FontWeight.normal
                                )),
                          ),
                        );
                      },
                    ).toList(),
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
