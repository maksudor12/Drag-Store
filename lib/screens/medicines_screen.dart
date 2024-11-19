import 'dart:io';
import 'package:drugstore_flutter/admin/login_screen.dart';
import 'package:drugstore_flutter/screens/CartScreen.dart';
import 'package:drugstore_flutter/screens/medicine_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../admin/admin_panel.dart';
import '../constants.dart';
import '../models/medicine_model.dart';
import '../repository/medicine_repository.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MedicineRepository _medicineRepository = MedicineRepository();
  List<Medicine> _medicines = [];
  List<Medicine> _filteredMedicines = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

  Future<void> _fetchMedicines() async {
    setState(() => _isLoading = true);
    _medicines = await _medicineRepository.getMedicines();
    setState(() {
      _filteredMedicines = List.from(_medicines);
      _isLoading = false;
    });
  }

  void _searchMedicine() async {
    setState(() => _isLoading = true);

    final query = _searchController.text.toLowerCase();
    _medicines = await _medicineRepository.searchMedicines(query);

    setState(() {
      _filteredMedicines = List.from(_medicines);
      _isLoading = false;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: const BoxDecoration(color: Colors.green),
              width: double.maxFinite,
              child: const Center(
                child: Text(
                  Constants.app_name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
              title: const Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                if (await _auth.currentUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPanel()),
                  );
                } else {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ));
                }
              },
              title: const Text(
                "Admin panel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                exit(0);
              },
              title: const Text(
                "Exit",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(Constants.app_name),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CartScreen();
                  },
                ));
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search medicine by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchMedicine();
                  },
                ),
              ),
              onChanged: (value) => _searchMedicine(),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _filteredMedicines.isEmpty
                        ? const Center(child: Text("No medicines found"))
                        : ListView.builder(
                            itemCount: _filteredMedicines.length,
                            itemBuilder: (context, index) {
                              final medicine = _filteredMedicines[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return MedicineDetail(medicine: medicine);
                                    },
                                  ));
                                },
                                child: ListTile(
                                  leading: medicine.image.isNotEmpty
                                      ? Image.network(
                                          medicine.image,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.medical_services),
                                  title: Text(medicine.name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        medicine.description,
                                        maxLines: 1,
                                      ),
                                      Text(
                                          "৳${medicine.price.toString()}/${medicine.unit}"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
