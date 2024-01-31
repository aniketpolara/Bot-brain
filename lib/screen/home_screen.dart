import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/controller/home_controller.dart';
import 'package:bot_brain/screen/chat_screen.dart';
import 'package:bot_brain/screen/code_screen.dart';
import 'package:bot_brain/screen/image_screen.dart';
import 'package:bot_brain/screen/setting_screen.dart';
import 'package:bot_brain/widget/home_screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: ConstantColors.assentBgTextAndBorder01,
                body: SingleChildScrollView(
                  child: Container(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 8),
                                    child: SvgPicture.asset(
                                      "assets/images/logo.svg",
                                    ),
                                  ),
                                  Text(
                                    "BotBrain",
                                    style:
                                        TextStyle(fontFamily: "InstrumentSans", color: ConstantColors.primaryMain, fontWeight: FontWeight.w700, fontSize: 24),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(const SettingScreen());
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/border/setting.svg",
                                      // ignore: deprecated_member_use
                                      color: ConstantColors.lightBlue04,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Share.share(Constant.shareAppUrl!);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 19, left: 17),
                                      child: SvgPicture.asset(
                                        "assets/icons/border/share.svg",
                                        // ignore: deprecated_member_use
                                        color: ConstantColors.lightBlue04,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          color: ConstantColors.lightBlue02,
                        ),
                        controller.bannerAdIsLoaded.value && controller.bannerAd != null
                            ? SizedBox(
                                height: controller.bannerAd!.size.height.toDouble(),
                                width: controller.bannerAd!.size.width.toDouble(),
                                child: AdWidget(ad: controller.bannerAd!))
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello 👋",
                                style: GoogleFonts.interTight(
                                  textStyle: TextStyle(color: ConstantColors.assentBgTextAndBorder04, fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                "Let’s see what can I do for you?",
                                style: GoogleFonts.interTight(
                                  textStyle: TextStyle(color: ConstantColors.assentBGTextAndBorder06, fontSize: 18, height: 1.5, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 24),
                              InkWell(
                                onTap: () {
                                  Get.to(const ChatScreen());
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 294,
                                      height: 56,
                                      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
                                      decoration: BoxDecoration(color: ConstantColors.assentBgTextAndBorder03, borderRadius: BorderRadius.circular(36)),
                                      child: TextFormField(
                                        cursorColor: Colors.white,
                                        enabled: false,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration.collapsed(
                                          hintText: "Send a message.",
                                          hintStyle: GoogleFonts.interTight(
                                            textStyle: GoogleFonts.interTight(
                                              textStyle: TextStyle(color: ConstantColors.primary06, fontWeight: FontWeight.w500, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor: ConstantColors.primaryMain,
                                      child: SvgPicture.asset(
                                        "assets/icons/fill/send.svg",
                                        // ignore: deprecated_member_use
                                        color: ConstantColors.primary01,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(const ChatScreen());
                                    },
                                    child: Container(
                                      height: 279,
                                      width: 171,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/voice_helper.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "BOT HELPER",
                                              style: GoogleFonts.interTight(
                                                  textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: ConstantColors.primary06,
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 21, bottom: 49),
                                              child: CircleAvatar(
                                                  backgroundColor: ConstantColors.primary05,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/fill/chat.svg",
                                                    // ignore: deprecated_member_use
                                                    color: ConstantColors.primary03,
                                                  )),
                                            ),
                                            const Text(
                                              "Let’s Start new things using AI Chat Bot",
                                              style: TextStyle(fontFamily: "InstrumentSans", fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 38,
                                              width: 123,
                                              decoration: BoxDecoration(color: ConstantColors.primary06, borderRadius: BorderRadius.circular(200)),
                                              child: Center(
                                                child: Text(
                                                  "Get Started",
                                                  style: GoogleFonts.interTight(
                                                    textStyle: TextStyle(color: ConstantColors.primaryMain, fontSize: 14, fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(const CodeScreen());
                                        },
                                        child: const HomeScreenContainer(
                                          image: "assets/icons/border/code_icon.svg",
                                          text: "Get the Code and Queries",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(const ImageScreen());
                                        },
                                        child: const HomeScreenContainer(
                                          image: "assets/icons/fill/image_icon.svg",
                                          text: "Find a Beautiful Images",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
