class Medicine {
  String id;
  String name;
  String image;
  String description;
  double price;
  String unit;

  Medicine({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.unit,
  });

  // Convert Medicine object to Firestore document format
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'unit': unit,
    };
  }

  // Create Medicine object from Firestore document
  static Medicine fromMap(Map<String, dynamic> map, String documentId) {
    return Medicine(
      id: documentId,
      name: map['name'],
      image: map['image'],
      description: map['description'],
      price: map['price'].toDouble(),
      unit: map['unit'],
    );
  }
}
