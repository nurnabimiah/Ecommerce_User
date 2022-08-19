
import 'package:ecom_user_starter/customwidgets/product_item.dart';
import 'package:ecom_user_starter/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/main_drawer.dart';
import '../providers/product_provider.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  static const String routeName = '/product_list';

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductProvider _productProvider;
  late CartProvider _cartProvider;


  @override
  void initState() {

  }

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    _cartProvider = Provider.of<CartProvider>(context);
    _productProvider.getAllProducts();
    _cartProvider.getAllCartItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.65,
        children: _productProvider.productList.map((e) => ProductItem(e)).toList(),
      ),
    );
  }
}
