import 'dart:developer';
import 'dart:io';

import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/model/chat_model.dart';
import 'package:bot_brain/utils/api_services.dart';
import 'package:bot_brain/utils/prafrences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CodeController extends GetxController {
  RxList<ChatModel> sendDataList = <ChatModel>[].obs;
  RxList<ChatModel> dataList = <ChatModel>[].obs;

  TextEditingController codeSearchController = TextEditingController();

  addData() async {
    sendDataList.add(ChatModel(text: codeSearchController.text, isuser: true));
    if (Preferences.getInt(Preferences.codeSearchCount.toString()) < Constant.codeSearchCount! || Constant.codeSearchCount == 0) {
      dataList.clear();
      dataList.add(ChatModel(text: codeSearchController.text, isuser: true));
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      showInterstitialAd();
      await ApiServices.chatCompeletionResponse(codeSearchController.text).then((value) async {

        log(value.toString());
        if (value.isNotEmpty) {
          dataList.add(ChatModel(text: value, isuser: false));
          Preferences.setInt(Preferences.codeSearchCount.toString(), Preferences.getInt(Preferences.codeSearchCount.toString()) + 1);
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
        codeSearchController.clear();
        Get.forceAppUpdate();
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
      createInterstitialAd();
    }
    super.onInit();
  }

  BannerAd? bannerAd;
  RxBool bannerAdIsLoaded = false.obs;
  InterstitialAd? interstitialAd;
  int numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  loadBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? Constant.bannerAndroidAdmobAdId.toString() : Constant.bannerIOSAdmobAdId.toString(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            if (kDebugMode) {
              print('$BannerAd Home loaded.');
            }
            bannerAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            if (kDebugMode) {
              print('$BannerAd Home failedToLoad: $error');
            }
            ad.dispose();
          },
          // ignore: avoid_print
          onAdOpened: (Ad ad) => print('$BannerAd Home onAdOpened.'),
          // ignore: avoid_print
          onAdClosed: (Ad ad) => print('$BannerAd Home onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();
  }

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid ? Constant.interstitialAndroidAdmobAdId.toString() : Constant.interstitialIOSAdmobAdId.toString(),
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
            numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      // ignore: avoid_print
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('Home ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }
}
