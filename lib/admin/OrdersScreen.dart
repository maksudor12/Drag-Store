import 'package:drugstore_flutter/admin/order_detail.dart';
import 'package:drugstore_flutter/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderModel> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Fetch orders on screen load
  }

  // Fetch orders from Firestore and filter by order_date
  Future<void> _fetchOrders() async {
    try {
      final ordersQuery = await FirebaseFirestore.instance
          .collection('orders')
          .orderBy('order_date',
              descending: true) // Order by order_date (most recent first)
          .get();

      setState(() {
        orders = ordersQuery.docs.map((doc) {
          return OrderModel.fromFirestore(doc.data());
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching orders: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Format the order date
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
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
        title: Text("Orders"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : orders.isEmpty
              ? Center(child: Text("No orders found"))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text("Name: ${order.name}"),
                        subtitle: Text(
                          "Number: ${order.mobile_number}\nTotal: ৳ ${order.totalPrice} \nOrder Date: ${_formatDate(order.orderDate)}",
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                       
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetail(order: order),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }

  // Method to show order details in a dialog
  void _showOrderDetails(OrderModel order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: ${order.name}"),
              Text("Total Price: ৳ ${order.totalPrice}"),
              SizedBox(height: 10),
              Text("Items:"),
              ...order.orderItems.map<Widget>((item) {
                return Text(
                  "Medicine ID: ${item.medicineId} | Quantity: ${item.quantity} | Sub Total: ৳ ${item.subTotal}",
                );
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
