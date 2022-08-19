
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart_page';
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartProvider _cartProvider;

  @override
  void didChangeDependencies() {
    _cartProvider = Provider.of<CartProvider>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white
            ),
            child: Text('CLEAR'),
            onPressed: () {
              _cartProvider.clearCart();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _cartProvider.cartList.length,
                itemBuilder: (context, index) {
                  final model = _cartProvider.cartList[index];
                  return ListTile(
                    title: Text(model.productName),
                    subtitle: Text('$takaSymbol${model.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            _cartProvider.decreaseQty(model);
                          },
                        ),
                        Text('${model.qty}'),
                        IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () {
                            _cartProvider.increaseQty(model);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: $takaSymbol${_cartProvider.cartItemsTotalPrice}', style: TextStyle(fontSize: 18),),
                  TextButton(
                    child: const Text('Checkout'),
                    onPressed: _cartProvider.totalItemsInCart == 0 ? null
                        : () {
                      Navigator.pushNamed(context, CheckoutPage.routeName);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showEmailVerficationAlert() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Unverified User!'),
      content: const Text('Your email is not verified yet. Please click the SEND button below to receive a verification mail'),
      actions: [
        TextButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('SEND'),
          onPressed: () {
            Navigator.pop(context);
            AuthService.sendVerificationMail().then((value) {
              //showMsg(context, 'Mail sent. Pleae check your inbox');
              print('Mail Sent');
            }).catchError((error) {
              throw error;
            });
          },
        ),

      ],
    ));
  }
}
