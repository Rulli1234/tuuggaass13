// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShoppingItem {
  final int? id;
  final String nama;
  final String kategori;
  final String catatan;

  ShoppingItem({
    this.id,
    required this.nama,
    required this.kategori,
    required this.catatan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'catatan': catatan,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      kategori: map['kategori'] as String,
      catatan: map['catatan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingItem.fromJson(String source) =>
      ShoppingItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
