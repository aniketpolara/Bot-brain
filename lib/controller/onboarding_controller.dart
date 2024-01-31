import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/onboarding_model.dart';

class OnBordingController extends GetxController {
  PageController pageController = PageController();

  RxList<OnBoardingModel> onBoardingList = <OnBoardingModel>[].obs;

  setOnBoardingList() {
    onBoardingList
        .add(OnBoardingModel(image: "assets/images/image_01.png", text: "Chat smarter with AI", text1: "Say goodbye to frustrating chat experiences!"));
    onBoardingList
        .add(OnBoardingModel(image: "assets/images/image_02.png", text: "Conversations like Pro", text1: "Say goodbye to frustrating chat experiences!"));
    onBoardingList.add(OnBoardingModel(
        image: "assets/images/image_03.png", text: "Take the better answers", text1: "Understand your queries and provide you with relevant responses."));
  }

  var selectedPageIndex = 0.obs;

  @override
  void onInit() {
    setOnBoardingList();
    super.onInit();
  }
}
