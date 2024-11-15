import 'package:drugstore_flutter/screens/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:drugstore_flutter/models/medicine_model.dart';
import 'package:drugstore_flutter/services/cart_service.dart';

class MedicineDetail extends StatelessWidget {
  final Medicine medicine;
  final bool isAdmin;
  final CartService _cartService = CartService();

  MedicineDetail({Key? key, required this.medicine, this.isAdmin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Detail"),
        actions: isAdmin == false
            ? [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CartScreen();
                        },
                      ));
                    },
                    icon: Icon(Icons.shopping_cart_outlined))
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              medicine.image,
              width: device.width,
              height: 240,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Price: ৳ ${medicine.price.ceilToDouble()} / ${medicine.unit}",
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700])),
                      if (isAdmin == false)
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _cartService.addToCart(
                                  medicine.id, medicine.price);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added to cart")),
                              );
                            },
                            child: Text("Add to Cart"),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(medicine.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
