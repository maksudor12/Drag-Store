import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String name;
  
    final String mobile_number;

  final double totalPrice;
  final DateTime orderDate;
  final List<OrderItem> orderItems;

  OrderModel({
    required this.name,
    required this.totalPrice,
    required this.orderDate,
    required this.orderItems,
    required this.mobile_number
  });

  // Factory method to create an Order from Firestore document
  factory OrderModel.fromFirestore(Map<String, dynamic> doc) {
    var items = (doc['order_items'] as List)
        .map((item) => OrderItem.fromMap(item))
        .toList();

    return OrderModel(
      name: doc['name'],
      mobile_number: doc['mobile_number'],
      totalPrice: doc['total_price'],
      orderDate: (doc['order_date'] as Timestamp).toDate(),
      orderItems: items,
    );
  }
}

class OrderItem {
  final String medicineId;
  final int quantity;
  final double subTotal;

  OrderItem({
    required this.medicineId,
    required this.quantity,
    required this.subTotal,
  });

  // Factory method to create an OrderItem from a map
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      medicineId: map['medicine_id'],
      quantity: map['quantity'],
      subTotal: map['sub_total'],
    );
  }
}
