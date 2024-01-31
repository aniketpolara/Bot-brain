import 'dart:developer';

import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/model/firebase_model.dart';
import 'package:bot_brain/screen/splash_screen.dart';
import 'package:bot_brain/utils/prafrences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Preferences.initPref();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ConstantColors.assentBgTextAndBorder01,
  ));

  await sendData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: ConstantColors.assentBgTextAndBorder01),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ConstantColors.primary01),
          primaryTextTheme: GoogleFonts.interTightTextTheme(),
          radioTheme: RadioThemeData(fillColor: MaterialStateColor.resolveWith((states) => ConstantColors.assentBgTextAndBorder04))),
      home: const SplashScreen(),
    );
  }
}

Future<void> sendData() async {
  try {
    await FirebaseFirestore.instance.collection("settings").doc("keys").get().then((value) async {
      if (value.exists) {
        FirebaseModel firebaseModel = FirebaseModel.fromJson(value.data()!);
        Constant.apiKey = firebaseModel.apiKey;

        Constant.chatSearchCount = firebaseModel.chatSearchCount; //set this for Unlimited Chat
        Constant.imageSearchCount = firebaseModel.imageSearchCount; //set this for Unlimited search Image
        Constant.codeSearchCount = firebaseModel.codeSearchCount; //set this for Unlimited search Prompt

        Constant.bannerAndroidAdmobAdId = firebaseModel.bannerAndroidAdmobAdId; //set your Android Admob Banner Ad Id
        Constant.interstitialAndroidAdmobAdId = firebaseModel.interstitialAndroidAdmobAdId; //set your Android Admob Interstitial Ad Id
        Constant.bannerIOSAdmobAdId = firebaseModel.bannerIOSAdmobAdId; //set your iOS Admob Banner Ad Id
        Constant.interstitialIOSAdmobAdId = firebaseModel.interstitialIOSAdmobAdId; //set your iOS Admob Interstitial Ad Id

        Constant.shareAppUrl = firebaseModel.shareAppUrl;
        Constant.privacyPolicyUrl = firebaseModel.privacyPolicyUrl;
        Constant.termsAndConditionAppUrl = firebaseModel.termsAndConditionAppUrl;
        Constant.supportEmail = firebaseModel.supportEmail;
        Constant.appVersion = firebaseModel.appVersion;

        Constant.isAdEnable = firebaseModel.isAdEnable;
      } else {
        await FirebaseFirestore.instance.collection("settings").doc("keys").set({
          "apiKey": "",

          "chatSearchCount": 0,
          "imageSearchCount": 0, //set this 0 for Unlimited search Image
          "codeSearchCount": 0, //set this 0 for Unlimited search Prompt

          "bannerAndroidAdmobAdId": "", //set your Android Admob Banner Ad Id
          "interstitialAndroidAdmobAdId": "", //set your Android Admob Interstitial Ad Id
          "bannerIOSAdmobAdId": "", //set your iOS Admob Banner Ad Id
          "interstitialIOSAdmobAdId": "", //set your iOS Admob Interstitial Ad Id

          "shareAppUrl": "",
          "privacyPolicy": "",
          "termsAndConditionAppUrl": "",
          "supportEmail": "",
          "appVersion": "",

          "isAdEnable": true
        });
        log("Done ");
      }
    });
  } catch (e) {
    debugPrint("=======${e.toString()}");
  }
}
