import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:shopping_app/extension/navigation.dart';
// import 'package:shopping_app/shared_preferences/shared_preferences.dart';
// import 'package:shopping_app/view/auth/login.dart';
// import 'package:shopping_app/view/main/bar_navigasi.dart';
import 'package:tugas13/extension/navigation.dart';
import 'package:tugas13/shared_preferences/shared_preferences.dart';
import 'package:tugas13/view/auth/login.dart';
import 'package:tugas13/view/main/home/bar_navigasi.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    bool? isLogin = await PreferenceHandler.getLogin();

    Future.delayed(Duration(seconds: 2)).then((value) async {
      print(isLogin);
      if (isLogin == true) {
        context.pushReplacementNamed(MainScreen.id);
      } else {
        context.push(Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/animations/List.json"),
            SizedBox(height: 20),
            Text("Kuy Belanja Brother"),
          ],
        ),
      ),
    );
  }
}
