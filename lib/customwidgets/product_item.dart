
import 'package:ecom_user_starter/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetailsPage.routeName, arguments: [widget.product.id, widget.product.name]),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          elevation: 7,
        child: Column(
          children: [
            widget.product.imageDownloadUrl == null ?
                Expanded(child: Image.asset('images/imagenotavailable.png', width: double.infinity, fit: BoxFit.cover,))
             :
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FadeInImage.assetNetwork(
                  image: widget.product.imageDownloadUrl!,
                  placeholder: 'images/imagenotavailable.png',
                  width: double.infinity,
                  fadeInDuration: const Duration(seconds: 3),
                  fadeInCurve: Curves.bounceInOut,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(widget.product.name!, style: TextStyle(fontSize: 16, color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('$takaSymbol${widget.product.price}', style: TextStyle(fontSize: 20, color: Colors.black),),
            ),
            Consumer<CartProvider>(
              builder: (context, provider, _) => ElevatedButton(
                child: Text(provider.isInCart(widget.product.id!) ? 'REMOVE' : 'ADD'),
                onPressed: () {
                  provider.isInCart(widget.product.id!) ?
                      provider.removeFromCart(widget.product.id!) :
                  provider.addToCart(widget.product);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
