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
        backgroundColor: const Color.fromARGB(255, 243, 191, 227),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 246, 202, 252),
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/images/animations/Welcome.json',
                    fit: BoxFit.contain,
                    repeat: true,
                    reverse: false,
                    animate: true,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Pengaturan Akun"),
            ),
            Divider(),
            ListTile(leading: Icon(Icons.pallet), title: Text("Tentang")),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Pengaturan Aplikasi"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.nightlight),
              title: Text("Mode  Gelap"),
            ),
            Divider(),
            SizedBox(height: 70),

            ElevatedButton(
              onPressed: () {
                PreferenceHandler.removeLogin();

                context.pushReplacementNamed(Login.id);
              },
              child: Text("LogOut"),
            ),
          ],
        ),
      ),
    );
  }
}
