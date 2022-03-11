import 'dart:convert';

import 'package:eshop/api/responses.dart';
import 'package:eshop/user_account/login.dart';
import 'package:eshop/utils/DataHolder.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {});
    getPrfefs();
  }

  goHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (__) {
      return const MainPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: const Center(
            child: Icon(
          Icons.shop,
          color: kPrimaryColor,
          size: 80,
        )),
      ),
    );
  }

  void getPrfefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogged = sharedPreferences.getBool(Keys.IS_LOGGED_KEY);
    if (isLogged == null || !isLogged) {
      goTOUserAccountPage();
    } else {
      var lr = sharedPreferences.getString(Keys.LOGIN_RESPONSE_KEY);
      // DataHolder.loginResponse = LoginResponse.fromJson(jsonDecode(lr!));
      // LoginResponse.fromJson(Data).apiKey
      goHome();
    }
  }

  void goTOUserAccountPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (__) {
      return const LoginPage();
    }));
  }
}
