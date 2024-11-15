import 'package:flutter/material.dart';
import 'package:drugstore_flutter/models/medicine_model.dart';
import 'package:drugstore_flutter/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatefulWidget {
  final OrderModel order;

  const OrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Map<String, Medicine> medicinesMap = {}; // Stores medicine data by ID
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedicines(); // Fetch medicine data based on medicine IDs in the order
  }

  // Fetch medicine details from Firestore for each order item
  Future<void> _fetchMedicines() async {
    try {
      for (var item in widget.order.orderItems) {
        // Fetch each medicine by its ID
        var medicineDoc = await FirebaseFirestore.instance
            .collection('medicines')
            .doc(item.medicineId)
            .get();

        if (medicineDoc.exists) {
          // Pass the document ID as well as data to fromMap
          var medicineData =
              Medicine.fromMap(medicineDoc.data()!, medicineDoc.id);
          setState(() {
            medicinesMap[item.medicineId] = medicineData;
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

  // Format orderDate to the desired format: "dd MMMM yyyy, hh:mm a"
  String formatOrderDate(DateTime date) {
    return DateFormat('dd MMMM yyyy, hh:mm a').format(date);
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name: ${widget.order.name}",
                      style: TextStyle(fontSize: 18)),
                  Text("Mobile Number: ${widget.order.mobile_number}",
                      style: TextStyle(fontSize: 18)),
                  Text("Total Price: ৳ ${widget.order.totalPrice}",
                      style: TextStyle(fontSize: 18)),
                  Text(
                      "Order Datetime: ${formatOrderDate(widget.order.orderDate)}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  Text("Order Items:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...widget.order.orderItems.map((item) {
                    final medicine = medicinesMap[item.medicineId];
                    return ListTile(
                      leading: medicine != null
                          ? Image.network(medicine.image,
                              width: 50, height: 50, fit: BoxFit.cover)
                          : Icon(Icons.medical_services),
                      title: Text(medicine != null
                          ? medicine.name
                          : "Unknown Medicine"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Quantity: ${item.quantity} | Sub Total: ৳ ${item.subTotal}"),
                          Text(medicine != null ? "Price: ৳ ${medicine.price}/${medicine.unit}" : ""),
                          Text("Sub Total: ৳ ${item.subTotal}")
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
