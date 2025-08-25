// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// import 'package:shopping_app/model/belanja.dart';
// import 'package:shopping_app/sqflite/db_helper.dart';
import 'package:tugas13/model/belanja.dart';
import 'package:tugas13/sqflite/db_helper.dart';

class AddShoppingPage extends StatefulWidget {
  const AddShoppingPage({super.key});

  @override
  State<AddShoppingPage> createState() => _AddShoppingPageState();
}

class _AddShoppingPageState extends State<AddShoppingPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _catatanController = TextEditingController();

  String? _kategori;
  final List<String> kategoriList = [
    "Laptop",
    "AC",
    "Sparepart AC",
    "Sparepart Laptop",
  ];

  // Fungsi untuk menyimpan data
  Future<void> _simpanData() async {
    if (_formKey.currentState!.validate() && _kategori != null) {
      final newItem = ShoppingItem(
        nama: _namaController.text,
        kategori: _kategori!,
        catatan: _catatanController.text,
      );

      try {
        await DbHelper.insertShoppingItem(newItem);

        // Tampilkan snackbar sebagai feedback bahwa data tersimpan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil disimpan!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Reset form
        _formKey.currentState!.reset();
        _namaController.clear();
        _catatanController.clear();
        setState(() {
          _kategori = null;
        });
      } catch (e) {
        // Tampilkan error jika gagal menyimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan data: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Tampilkan pesan jika kategori belum dipilih
      if (_kategori == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap pilih kategori!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah barang"),
        backgroundColor: const Color.fromARGB(255, 92, 189, 59),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: "Nama Barang"),
                  validator: (value) =>
                      value!.isEmpty ? "Harap isi nama barang" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _kategori,
                  decoration: const InputDecoration(labelText: "Kategori"),
                  items: kategoriList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _kategori = value),
                  validator: (value) => value == null ? "Pilih kategori" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _catatanController,
                  decoration: const InputDecoration(labelText: "Catatan"),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _simpanData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Simpan", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _catatanController.dispose();
    super.dispose();
  }
}
