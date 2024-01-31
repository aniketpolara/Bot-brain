import 'dart:io';

import 'package:bot_brain/constant/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController{
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
}