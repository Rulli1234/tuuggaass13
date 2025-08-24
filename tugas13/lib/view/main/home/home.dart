import 'package:flutter/material.dart';
// import 'package:shopping_app/model/belanja.dart';
// import 'package:shopping_app/sqflite/db_helper.dart';
import 'package:tugas13/model/belanja.dart';
import 'package:tugas13/sqflite/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShoppingItem> items = [];
  final List<String> kategoriList = [
    "Makanan",
    "Minuman",
    "Elektronik",
    "Pakaian",
  ];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final data = await DbHelper.getAllShoppingItem();
    setState(() {
      items = data;
    });
  }

  void _editItem(ShoppingItem item) {
    final namaController = TextEditingController(text: item.nama);
    final catatanController = TextEditingController(text: item.catatan);
    String? selectedKategori = item.kategori;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedKategori,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: kategoriList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedKategori = newValue;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: catatanController,
                decoration: const InputDecoration(labelText: 'Catatan'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (namaController.text.isNotEmpty && selectedKategori != null) {
                final updatedItem = ShoppingItem(
                  id: item.id,
                  nama: namaController.text,
                  kategori: selectedKategori!,
                  catatan: catatanController.text,
                );

                try {
                  await DbHelper.updateShoppingItem(updatedItem);
                  _loadItems();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil diupdate!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal mengupdate data: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Harap isi semua field!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Belanja"),
        backgroundColor: const Color.fromARGB(255, 243, 191, 227),
      ),
      body: items.isEmpty
          ? const Center(child: Text("Belum ada data"))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return Card(
                  color: const Color.fromARGB(255, 243, 191, 227),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item.nama),
                    subtitle: Text(
                      "Kategori: ${item.kategori}\nCatatan: ${item.catatan}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _editItem(item),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () async {
                            await DbHelper.deleteShoppingItem(item.id!);
                            _loadItems();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data berhasil dihapus!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
