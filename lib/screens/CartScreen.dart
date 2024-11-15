import 'package:flutter/material.dart';
import 'package:drugstore_flutter/services/cart_service.dart';
import 'package:drugstore_flutter/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/medicine_model.dart'; // Firebase Firestore

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<CartItem> cartItems = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Map<String, Medicine> medicinesMap = {}; // Stores medicine data by ID
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadCartItems(); // Load cart items initially
    _fetchMedicines(); // Fetch medicine data based on medicine IDs in the order
  }

  // Fetch medicine details from Firestore for each order item
  Future<void> _fetchMedicines() async {
    try {
      for (var item in cartItems) {
        // Fetch each medicine by its ID
        var medicineDoc = await FirebaseFirestore.instance
            .collection('medicines')
            .doc(item.medicine_id)
            .get();

        if (medicineDoc.exists) {
          // Pass the document ID as well as data to fromMap
          var medicineData =
              Medicine.fromMap(medicineDoc.data()!, medicineDoc.id);
          setState(() {
            medicinesMap[item.medicine_id] = medicineData;
          });
        }
      }
    } catch (e) {
      print("Error fetching medicines: $e");
    } finally {
      setState(() {
        isLoading = false; // Mark loading as false after fetching is complete
      });
    }
  }

  // Method to load cart items
  Future<void> _loadCartItems() async {
    final items = await _cartService.getCartItems();
    setState(() {
      cartItems = items;
    });
  }

  // Method to calculate the total price of all cart items
  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.sub_total; // Add the sub_total of each item
    }
    return total;
  }

  Future<void> _placeOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Collect order details
      final orderData = {
        'name': _nameController.text,
        'mobile_number': _mobileController.text,
        'shipping_address': _addressController.text,
        'total_price': totalPrice,
        'order_items': cartItems
            .map((item) => {
                  'medicine_id': item.medicine_id,
                  'quantity': item.quantity,
                  'sub_total': item.sub_total,
                })
            .toList(),
        'order_date': Timestamp.now(),
      };

      try {
        // Send the order to Firebase
        await FirebaseFirestore.instance.collection('orders').add(orderData);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Order placed successfully!"),
        ));

        // Clear the cart after placing the order
        _cartService.clearCart(); // Ensure the cart is cleared from the service

        // Manually update the cartItems list and trigger state refresh
        setState(() {
          cartItems = []; // Clear the list of cart items in the UI
        });

        // Clear the form controllers
        _nameController.clear();
        _mobileController.clear();
        _addressController.clear();

        Navigator.pop(context); // Close the dialog
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to place the order. Please try again."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text("Medicine ID: ${item.medicine_id}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quantity: ${item.quantity}"),
                            Text("৳ ${item.sub_total}")
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _cartService.removeFromCart(item.medicine_id);
                            _loadCartItems(); // Refresh the cart after removing item
                          },
                        ),
                        onTap: () {
                          _showQuantityDialog(item);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? ListTile(
              title: Text(
                "Total: ৳ ${totalPrice.toStringAsFixed(2)}", // Display the total price
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: ElevatedButton(
                onPressed:
                    cartItems.isNotEmpty ? _showOrderDetailsDialog : null,
                child: Text("Place Order"),
              ),
            )
          : null,
    );
  }

  // Show dialog to collect user details for the order
  void _showOrderDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Order Details"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Full Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(labelText: "Mobile Number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your mobile number";
                    }
                    final phoneRegExp = RegExp(r"^\+?[0-9]{10,15}$");
                    if (!phoneRegExp.hasMatch(value)) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: "Shipping Address"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a shipping address";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                _placeOrder(); // Place the order
              },
              child: Text("Place Order"),
            ),
          ],
        );
      },
    );
  }

  // Method to show the quantity dialog (existing functionality)
  void _showQuantityDialog(CartItem item) {
    int quantity = item.quantity;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Modify Quantity"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() => quantity++);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    double price = item.sub_total / item.quantity;
                    _cartService.updateQuantity(
                        item.medicine_id, price, quantity);

                    Navigator.pop(context);
                    _loadCartItems(); // Refresh the cart after updating the quantity
                  },
                  child: Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
