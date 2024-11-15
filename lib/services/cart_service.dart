import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item_model.dart';

class CartService {
  final Box<Map> _cartBox = Hive.box<Map>('cartBox');

  List<CartItem> getCartItems() {
    return _cartBox.values
        .map((map) => CartItem.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  void addToCart(String medicineId, double price) {
    final existingItem = _cartBox.get(medicineId);
    if (existingItem != null) {
      int newQuantity = existingItem['quantity'] + 1;
      double newSubTotal = newQuantity * price;
      _cartBox.put(medicineId, {
        'medicine_id': medicineId,
        'sub_total': newSubTotal,
        'quantity': newQuantity,
      });
    } else {
      // New item in the cart
      _cartBox.put(medicineId, {
        'medicine_id': medicineId,
        'sub_total': price,
        'quantity': 1,
      });
    }
  }

  void updateQuantity(String medicineId, double price, int newQuantity) {
    if (_cartBox.containsKey(medicineId)) {
      double newSubTotal = newQuantity * price;
      _cartBox.put(medicineId, {
        'medicine_id': medicineId,
        'sub_total': newSubTotal,
        'quantity': newQuantity,
      });
    }
  }

  void removeFromCart(String medicineId) {
    _cartBox.delete(medicineId);
  }

  void clearCart() {
    _cartBox.clear();
  }
}
