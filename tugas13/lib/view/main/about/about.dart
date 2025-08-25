import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:shopping_app/extension/navigation.dart';
// import 'package:shopping_app/shared_preferences/shared_preferences.dart';
// import 'package:shopping_app/view/auth/login.dart';
import 'package:tugas13/extension/navigation.dart';
import 'package:tugas13/shared_preferences/shared_preferences.dart';
import 'package:tugas13/view/auth/login.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        backgroundColor: const Color.fromARGB(255, 92, 189, 59),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_2),
              title: Text("Pengaturan Akun"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.android),
              title: Text("Tentang Aplikasi"),
            ),
            Divider(),

            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                PreferenceHandler.removeLogin();

                context.pushReplacementNamed(Login.id);
              },
              child: Text("Keluar Akun"),
            ),
          ],
        ),
      ),
    );
  }
}
