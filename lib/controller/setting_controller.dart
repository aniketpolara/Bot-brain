import 'dart:io';

import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/model/setting_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  RxList<SettingModel> settingList = <SettingModel>[].obs;

  Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();

  @override
  void onInit() {
    if(Constant.isAdEnable!){
      loadBannerAd();
    }
    setSettingList();
    super.onInit();
  }

  setSettingList() {
    settingList.add(SettingModel(image: "assets/icons/fill/message.svg", text: "Contact us", url: Constant.supportEmail));
    settingList.add(SettingModel(image: "assets/icons/fill/doc.svg", text: "Terms of Conditions", url: Constant.termsAndConditionAppUrl));
    settingList.add(SettingModel(image: "assets/icons/fill/Note.svg", text: "Privacy Policy", url: Constant.termsAndConditionAppUrl));
  }

  openUrl(String url) async {
    var url = Uri.parse(Constant.termsAndConditionAppUrl!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  void launchEmailSupport() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Constant.supportEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Help & Support',
      }),
    );
    launchUrl(emailLaunchUri);
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
