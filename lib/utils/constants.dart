const String emptyFieldErrMsg = 'This field must not be empty';
const String takaSymbol = '৳';
const String photoDirectory = 'PBFlutter05';
const negativePriceErrMsg = 'Price shouldn\'t be less than 0';
const negativeStockErrMsg = 'Quantity should be greater than 0';

class OrderStatus {
  static const String pending = 'Pending';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
}

class Payment {
  static const String cod = 'Cash on Delivery';
  static const String online = 'Online Payment';
}