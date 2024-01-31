import 'dart:developer';
import 'dart:io';

import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/model/chat_model.dart';
import 'package:bot_brain/model/image_mode.dart';
import 'package:bot_brain/utils/api_services.dart';
import 'package:bot_brain/utils/prafrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ImageController extends GetxController {
  Rx<TextEditingController> imageTextController = TextEditingController().obs;
  RxList<ImageData> imageList = <ImageData>[].obs;
  RxString genderRadioBtnVal = '256x256'.obs;
  RxList<ChatModel> chatDataList = <ChatModel>[].obs;
  TextEditingController textEditingController = TextEditingController();

  void handleGenderChange(String value) {
    genderRadioBtnVal.value = value;
  }

  searchImage() async {
    imageList.clear();
    if (Preferences.getInt(Preferences.imageSearchCount.toString()) < Constant.imageSearchCount! || Constant.imageSearchCount == 0) {
      chatDataList.clear();
      chatDataList.add(ChatModel(text: imageTextController.value.text, isuser: true));
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );

      await ApiServices.imageGenerateResponse(imageTextController.value.text, genderRadioBtnVal.value).then((value) async {
        log(value.toString());
        if (value != null) {
          imageList.value = value;
          Preferences.setInt(Preferences.imageSearchCount.toString(), Preferences.getInt(Preferences.imageSearchCount.toString()) + 1);
          chatDataList.add(ChatModel(text: "Sure, here is the ${imageTextController.value.text}", isuser: false));
        } else {
          Get.snackbar(
            "Something went wrong",
            "No Image Generated...!",
            backgroundColor: ConstantColors.red,
            snackPosition: SnackPosition.TOP,
            colorText: ConstantColors.primary06,
            borderRadius: 10,
          );
        }
        imageTextController.value.clear();
        await EasyLoading.dismiss();
      });
    } else {
      Get.snackbar(
        'Alert!',
        "Your Demo Request Is Over",
        backgroundColor: ConstantColors.red,
        snackPosition: SnackPosition.TOP,
        colorText: ConstantColors.primary06,
        borderRadius: 10,
      );
    }
  }

  @override
  void onInit() {
    if(Constant.isAdEnable!){
      loadBannerAd();
    }
    super.onInit();
  }

  BannerAd? bannerAd;
  RxBool bannerAdIsLoaded = false.obs;

  loadBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? Constant.bannerAndroidAdmobAdId.toString() : Constant.bannerIOSAdmobAdId.toString(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            if (kDebugMode) {
              print('$BannerAd Setting loaded.');
            }
            bannerAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // ignore: avoid_print
            print('$BannerAd Setting failedToLoad: $error');
            ad.dispose();
          },
          // ignore: avoid_print
          onAdOpened: (Ad ad) => print('$BannerAd Setting onAdOpened.'),
          // ignore: avoid_print
          onAdClosed: (Ad ad) => print('$BannerAd Setting onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();
  }

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
}
