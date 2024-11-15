import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/medicine_model.dart';

class MedicineRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Add new medicine to Firestore
  Future<void> addMedicine(Medicine medicine) async {
    try {
      // Add medicine data to Firestore
      await _firestore.collection('medicines').add({
        'name': medicine.name,
        'image': medicine.image,
        'description': medicine.description,
        'price': medicine.price,
        'unit': medicine.unit,
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // Upload image to Firebase Storage
  Future<String> uploadImage(XFile imageFile) async {
    final storageRef =
        _storage.ref().child('medicine_images/${imageFile.name}');
    await storageRef.putFile(File(imageFile.path));
    return await storageRef.getDownloadURL();
  }

  // Retrieve list of medicines from Firestore
  Future<List<Medicine>> getMedicines() async {
    final snapshot = await _firestore.collection('medicines').get();

    return snapshot.docs
        .map((doc) => Medicine.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Retrieve list by search query of medicines from Firestore
  Future<List<Medicine>> searchMedicines(String searchQuery) async {
    final snapshot = await _firestore.collection('medicines').get();
    final filteredDocuments = snapshot.docs
        .where((doc) => doc['name']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return filteredDocuments
        .map((doc) => Medicine.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Update an existing medicine entry
  Future<void> updateMedicine(Medicine medicine) async {
    await _firestore
        .collection('medicines')
        .doc(medicine.id)
        .update(medicine.toMap());
  }

  // Delete a medicine entry
  Future<void> deleteMedicine(String id) async {
    await _firestore.collection('medicines').doc(id).delete();
  }
}
