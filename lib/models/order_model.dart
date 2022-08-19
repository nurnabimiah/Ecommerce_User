
import 'package:cloud_firestore/cloud_firestore.dart';

final String ORDER_ID = 'orderId';
final String USER_ID = 'user_id';
final String ORDER_TIMESTAMP = 'orderTimestamp';
final String ORDER_GRANDTOTAL = 'orderGrandTotal';
final String ORDER_DISCOUNT = 'orderDiscount';
final String ORDER_DELIVERY_CHARGE = 'orderDeliveryCharge';
final String ORDER_VAT = 'vat';
final String ORDER_ORDER_STATUS = 'orderStatus';
final String ORDER_PAYMENT_METHOD = 'orderPaymentMethod';
final String ORDER_DELIVERY_ADDRESS = 'orderDeliveryAddress';

class OrderModel {
  String? orderId;
  Timestamp timestamp;
  String userId;
  num grandTotal;
  int discount;
  int deliveryCharge;
  int vat;
  String orderStatus;
  String paymentMethod;
  String deliveryAddress;

  OrderModel(
      {
        this.orderId,
        required this.timestamp,
        required this.grandTotal,
        required this.discount,
        required this.deliveryCharge,
        required this.vat,
        required this.orderStatus,
        required this.userId,
        required this.deliveryAddress,
        required this.paymentMethod});

  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      ORDER_ID : orderId,
      USER_ID: userId,
      ORDER_TIMESTAMP : timestamp,
      ORDER_GRANDTOTAL : grandTotal,
      ORDER_DISCOUNT : discount,
      ORDER_DELIVERY_CHARGE : deliveryCharge,
      ORDER_VAT : vat,
      ORDER_ORDER_STATUS : orderStatus,
      ORDER_PAYMENT_METHOD : paymentMethod,
      ORDER_DELIVERY_ADDRESS : deliveryAddress,
    };

    return map;
  }

    factory OrderModel.fromMap(Map<String,dynamic> map) => OrderModel(
    orderId : map[ORDER_ID],
    userId : map[USER_ID],
    timestamp : map[ORDER_TIMESTAMP],
    grandTotal : map[ORDER_GRANDTOTAL],
    discount : map[ORDER_DISCOUNT],
    deliveryCharge : map[ORDER_DELIVERY_CHARGE],
    vat : map[ORDER_VAT],
    orderStatus : map[ORDER_ORDER_STATUS],
    paymentMethod : map[ORDER_PAYMENT_METHOD],
    deliveryAddress : map[ORDER_DELIVERY_ADDRESS]);

  @override
  String toString() {
    return 'OrderModel{orderId: $orderId, timestamp: $timestamp, userId: $userId, grandTotal: $grandTotal, discount: $discount, deliveryCharge: $deliveryCharge, vat: $vat, orderStatus: $orderStatus, paymentMethod: $paymentMethod}';
  }
}