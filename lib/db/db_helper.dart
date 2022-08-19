import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

class DBHelper {
  static const _collectionProduct = 'Products';
  static const _collectionCategory = 'Categories';
  static const _collectionUser = 'Users';
  static const _collectionCart = 'Cart';
  static const _collectionOrder = 'Orders';
  static const _collectionOrderDetails = 'OrderDetails';
  static const _collectionOrderUtils = 'OrderUtils';
  static const _documentConstants = 'Constants';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addNewUser(UserModel userModel) {
    return _db.collection(_collectionUser).doc(userModel.userId).set(userModel.toMap());
  }

  static Future<void> updateDeliveryAddress(String userId, String address) {
    return _db.collection(_collectionUser)
        .doc(userId)
        .update({'deliveryAddress' : address});
  }

  static Future<void> addToCart(String userId, CartModel cartModel) {
    return _db.collection(_collectionUser)
        .doc(userId)
        .collection(_collectionCart)
        .doc(cartModel.productId)
        .set(cartModel.toMap());
  }

  static Future<void> updateCartQuantity(String userId, CartModel cartModel) {
    return _db.collection(_collectionUser).doc(userId)
        .collection(_collectionCart)
        .doc(cartModel.productId)
        .update({'qty' : cartModel.qty});
  }

  static Future<void> removeFromCart(String userId, String productId) {
    return _db.collection(_collectionUser)
        .doc(userId)
        .collection(_collectionCart)
        .doc(productId)
        .delete();
  }

  static Future<void> removeAllItemsFromCart(String userId, List<CartModel> cartList) {
    final wb = _db.batch();
    for (var cart in cartList) {
      final cartDoc = _db.collection(_collectionUser).doc(userId)
          .collection(_collectionCart).doc(cart.productId);
      wb.delete(cartDoc);
    }
    return wb.commit();

  }

  static Future<void> addNewOrder(OrderModel orderModel, List<CartModel> cartList) {
    final wb = _db.batch();
    final orderDoc = _db.collection(_collectionOrder).doc();
    orderModel.orderId = orderDoc.id;
    wb.set(orderDoc, orderModel.toMap());
    for (var value in cartList) {
      final doc = orderDoc.collection(_collectionOrderDetails).doc(value.productId);
      wb.set(doc, value.toMap());
    }
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrdersByUser(String userId) =>
      _db.collection(_collectionOrder).where('user_id', isEqualTo: userId).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrderDetails(String orderId) =>
      _db.collection(_collectionOrder).doc(orderId).collection(_collectionOrderDetails).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCategories() =>
      _db.collection(_collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProducts() =>
      _db.collection(_collectionProduct).where('isAvailable', isEqualTo: true).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProductsByCategory(String category) =>
      _db.collection(_collectionProduct)
          .where('isAvailable', isEqualTo: true)
          .where('category', isEqualTo: category)
          .snapshots();
  
  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchProductByProductId(String productId) =>
      _db.collection(_collectionProduct).doc(productId).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchOrderConstants() =>
      _db.collection(_collectionOrderUtils).doc(_documentConstants).snapshots();

  static Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails(String userId) =>
      _db.collection(_collectionUser).doc(userId).get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCartItems(String userId) =>
      _db.collection(_collectionUser)
      .doc(userId).collection(_collectionCart).snapshots();
}