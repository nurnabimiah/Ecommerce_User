import 'package:ecom_user_starter/auth/auth_service.dart';
import 'package:ecom_user_starter/db/db_helper.dart';
import 'package:flutter/foundation.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  void addToCart(ProductModel productModel) {
    final cartModel = CartModel(productId: productModel.id!,
        productName: productModel.name!, price: productModel.price!);
    DBHelper.addToCart(AuthService.currentUser!.uid, cartModel);
  }

  void removeFromCart(String id) {
    DBHelper.removeFromCart(AuthService.currentUser!.uid, id);
  }

  void increaseQty(CartModel cartModel) {
    cartModel.qty += 1;
    DBHelper.updateCartQuantity(AuthService.currentUser!.uid, cartModel);
  }

  void decreaseQty(CartModel cartModel) {
    if(cartModel.qty > 1) {
      cartModel.qty -= 1;
      DBHelper.updateCartQuantity(AuthService.currentUser!.uid, cartModel);
    }
  }

  void clearCart() {
    DBHelper.removeAllItemsFromCart(AuthService.currentUser!.uid, cartList);
  }

  bool isInCart(String id) {
    bool tag = false;
    for(var cart in cartList) {
      if(cart.productId == id) {
        tag = true;
        break;
      }
    }
    return tag;
  }

  int get totalItemsInCart => cartList.length;

  num get cartItemsTotalPrice {
    num total = 0;
    cartList.forEach((element) {
      total += element.qty * element.price;
    });
    return total;
  }

  num grandTotal(int discount, int vat, int deliveryCharge) {
    var grandTotal = 0;

    return grandTotal;
  }

  void getAllCartItems() {
    DBHelper.fetchAllCartItems(AuthService.currentUser!.uid).listen((event) {
      cartList = List.generate(event.docs.length, (index) => CartModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
}