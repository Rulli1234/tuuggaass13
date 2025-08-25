// import 'package:flutter/gestures.dart';
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tugas13/extension/navigation.dart';
import 'package:tugas13/shared_preferences/shared_preferences.dart';
import 'package:tugas13/sqflite/db_helper.dart';
import 'package:tugas13/view/main/home/bar_navigasi.dart';
import 'package:tugas13/view/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const id = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    "Silahkan masukkan akun anda Brother",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Surel",
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
                      return "Surel Tidak Valid";
                    }
                    if (!value.contains("@")) {
                      return "Surel tidak valid";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Kata Sandi",
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
                      return "Kata Sandi tidak boleh kosong";
                    }
                    return null;
                  },
                ),

                InkWell(
                  onTap: () {
                    print("Lupa bang");
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Lupa Kata Sandi?",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 145, 57, 105),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                        // Check login credentials with database
                        final user = await DbHelper.loginUser(
                          emailController.text,
                          passwordController.text,
                        );

                        if (user != null) {
                          // TAMPILKAN DIALOG BERHASIL
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Berhasil"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Berhasil login Brother"),
                                    SizedBox(height: 50),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen(),
                                        ),
                                      );
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // TAMPILKAN DIALOG GAGAL
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("GAGAL"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Surel atau Kata Sandi salah"),
                                    SizedBox(height: 20),
                                    Lottie.asset(
                                      "assets/images/animations/Fail.json",
                                      width: 90,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },

                    child: Text(
                      "Masuk Brother",
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
                      text: "Belum punya akun? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Daftar Sekarang Brother",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 145, 57, 105),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DaftarAkun(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                // Lottie.asset(
                //   "assets/images/animations/Shopping Cart Loader.json",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Surel dan Kata Sandi tidak boleh kosong"),
        ),
      );
      // isLoading = false;

      return;
    }
    final userData = await DbHelper.loginUser(email, password);
    if (userData != null) {
      PreferenceHandler.saveLogin();
      context.pushReplacementNamed(login());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Surel atau Kata Sandi salah")),
      );
    }
  }
}
