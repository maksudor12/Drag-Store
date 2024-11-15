import 'package:flutter/material.dart';
import 'package:drugstore_flutter/screens/medicine_detail.dart';
import '../models/medicine_model.dart';
import '../repository/medicine_repository.dart';

class MedicinesAdmin extends StatefulWidget {
  const MedicinesAdmin({super.key});

  @override
  State<MedicinesAdmin> createState() => _MedicinesAdminState();
}

class _MedicinesAdminState extends State<MedicinesAdmin> {
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


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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



  Future<void> _showMedicineDialog({Medicine? medicine}) async {
    final TextEditingController _nameController = TextEditingController(text: medicine?.name ?? '');
    final TextEditingController _imageController = TextEditingController(text: medicine?.image ?? '');
    final TextEditingController _descriptionController = TextEditingController(text: medicine?.description ?? '');
    final TextEditingController _priceController = TextEditingController(text: medicine?.price.toString() ?? '');
    final TextEditingController _unitController = TextEditingController(text: medicine?.unit ?? '');

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(medicine == null ? 'Add Medicine' : 'Edit Medicine'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Image URL is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _unitController,
                  decoration: const InputDecoration(labelText: 'Unit'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unit is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final updatedMedicine = Medicine(
                    id: medicine?.id ?? '',
                    name: _nameController.text,
                    image: _imageController.text,
                    description: _descriptionController.text,
                    price: double.tryParse(_priceController.text) ?? 0.0,
                    unit: _unitController.text,
                  );

                  if (medicine == null) {
                    _addMedicine(updatedMedicine);
                  } else {
                    _updateMedicine(updatedMedicine);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(medicine == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addMedicine(Medicine medicine) async {
    await _medicineRepository.addMedicine(medicine);
    _fetchMedicines();
  }

  Future<void> _updateMedicine(Medicine medicine) async {
    await _medicineRepository.updateMedicine(medicine);
    _fetchMedicines();
  }

  Future<void> _deleteMedicine(String id) async {
    await _medicineRepository.deleteMedicine(id);
    _fetchMedicines(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicines"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showMedicineDialog(),
          ),
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
                                      return MedicineDetail(medicine: medicine,isAdmin: true,);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(medicine.description, maxLines: 1),
                                      Text("Price: ৳${medicine.price.toString()}/${medicine.unit}"),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _deleteMedicine(medicine.id),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => _showMedicineDialog(medicine: medicine),
                                      ),
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
