import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import '../constant/constant_colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<SettingController>(
          init: SettingController(),
          builder: (controller) {
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/bg_screen_image.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: ConstantColors.assentBGTextAndBorder06,
                                ),
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                    color: ConstantColors.assentBGTextAndBorder06, fontSize: 24, fontFamily: "InstrumentSans", fontWeight: FontWeight.w700),
                              ),
                              PopupMenuButton<int>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: ConstantColors.assentBGTextAndBorder06,
                                ),
                                constraints: const BoxConstraints.expand(width: 130, height: 60),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/border/share.svg",
                                          // ignore: deprecated_member_use
                                          color: ConstantColors.primary06,
                                        ),
                                        const SizedBox(width: 13),
                                        Text(
                                          "Share",
                                          style: GoogleFonts.interTight(
                                            textStyle: TextStyle(color: ConstantColors.primary06, fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                                offset: const Offset(0, 55),
                                color: ConstantColors.primary01,
                                elevation: 2,
                                onSelected: (value) {
                                  value == 1 ? Share.share(Constant.shareAppUrl!) : null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: ConstantColors.lightBlue02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                height: 240,
                                width: 358,
                                decoration: BoxDecoration(
                                  color: ConstantColors.gradient08,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ConstantColors.gradient09,
                                  ),
                                ),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 64, top: 3),
                                      child: Divider(
                                        thickness: 1,
                                        color: ConstantColors.assentBgTextAndBorder04,
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: controller.settingList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        onTap: () {
                                          index != 0 ? controller.openUrl(controller.settingList[index].url.toString()) : controller.launchEmailSupport();
                                        },
                                        leading: CircleAvatar(
                                            backgroundColor: ConstantColors.lightBlue02,
                                            maxRadius: 23,
                                            child: SvgPicture.asset(
                                              controller.settingList[index].image.toString(),
                                              // ignore: deprecated_member_use
                                              color: ConstantColors.primary06,
                                            )),
                                        title: Text(
                                          controller.settingList[index].text.toString(),
                                          style: GoogleFonts.interTight(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: ConstantColors.assentBGTextAndBorder06,
                                            ),
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                          color: ConstantColors.assentBgTextAndBorder04,
                                        ));
                                  },
                                ),
                              ),
                              const SizedBox(height: 31),
                              Text(
                                "Version ${Constant.appVersion}",
                                style: GoogleFonts.interTight(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: ConstantColors.assentBgTextAndBorder04,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                    controller.bannerAdIsLoaded.value && controller.bannerAd != null
                        ? SizedBox(
                            height: controller.bannerAd!.size.height.toDouble(),
                            width: controller.bannerAd!.size.width.toDouble(),
                            child: AdWidget(ad: controller.bannerAd!))
                        : const SizedBox()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
