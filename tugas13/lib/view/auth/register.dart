// import 'package:flutter/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tugas13/model/user.dart';
import 'package:tugas13/sqflite/db_helper.dart';

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({super.key});
  static const id = "/register";

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "Selamat Datang Brother",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Text(
                    "Brother ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(width: double.infinity, child: Text("Nama Pengguna")),
                SizedBox(height: 10),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama pengguna tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,

                  child: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email Tidak Valid";
                    }
                    if (!value.contains("@")) {
                      return "Email tidak valid";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: passwordController,
                  obscureText: _isPasswordHidden,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong";
                    }
                    if (value.length < 6) {
                      return "Password minimal 6 karakter";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,

                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 247, 230, 242),
                      ),
                    ),

                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // TAMPILKAN DIALOG BERHASIL
                        final penggunaBaru = User(
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        await DbHelper.insertPengguna(penggunaBaru);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Berhasil"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 50),
                                  // Lottie.asset(
                                  //   "assets/images/animations/successgraduation.json",
                                  //   width: 90,
                                  //   height: 100,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  SizedBox(height: 20),
                                  Text("Akun berhasil dibuat"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 2, 2, 2),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text.rich(
                    TextSpan(
                      text: "Sudah punya akun? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Masuk Sekarang",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 145, 57, 105),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
