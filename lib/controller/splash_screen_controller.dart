import 'dart:async';

import 'package:get/get.dart';

import '../screen/main_screen.dart';
import '../screen/onboarding_screen.dart';
import '../utils/prafrences.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    onNext();
    if (Preferences.getInt(Preferences.codeSearchCount.toString()) == 0 &&
        Preferences.getInt(Preferences.imageSearchCount.toString()) == 0 &&
        Preferences.getInt(Preferences.chatSearchCount.toString()) == 0) {
      Preferences.setInt(Preferences.codeSearchCount.toString(), 1);
      Preferences.setInt(Preferences.imageSearchCount.toString(), 1);
      Preferences.setInt(Preferences.chatSearchCount.toString(), 1);
    }
    super.onInit();
  }

  onNext() {
    Timer(const Duration(seconds: 3), () {
      if (!Preferences.getBoolean(Preferences.isFinishOnBoardingKey)) {
        Get.offAll(const OnBoardingScreen());
      } else {
        Get.offAll(const MainScreen());
      }
    });
  }
}
