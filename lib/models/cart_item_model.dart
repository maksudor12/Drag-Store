class CartItem {
  final String medicine_id;
  final double sub_total;
  final int quantity;

  CartItem({
    required this.medicine_id,
    required this.sub_total,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicine_id': medicine_id,
      'sub_total': sub_total,
      'quantity': quantity,
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      medicine_id: map['medicine_id'],
      sub_total: map['sub_total'],
      quantity: map['quantity'],
    );
  }
}
