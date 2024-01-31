import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import 'dashbord_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          style: TextStyle(
                              fontFamily: "InstrumentSans", color: ConstantColors.primaryMain, fontWeight: FontWeight.w700, fontSize: 24),
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
                            Share.share('com.example.bot_brain');
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
              Padding(
                padding: const EdgeInsets.only(top: 52, right: 76.67, left: 77.33),
                child: Text(
                  "Ask me anything...",
                  style: TextStyle(
                      fontFamily: "InstrumentSans",
                      color: ConstantColors.assentBGTextAndBorder06,
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Last Update 05 May 2023",
                style: GoogleFonts.interTight(
                  textStyle: TextStyle(color: ConstantColors.assentBgTextAndBorder04, fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: InkWell(
                    onTap: () {
                      Get.to(const DashbordScreen());
                    },
                    child: Image.asset("assets/images/tap_chat.png")),
              ),
              Image.asset("assets/images/fire_icon.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Text(
                  "How do I make an HTTP n JavaScript? Explain quantum computing in simple terms",
                  style: GoogleFonts.interTight(
                    textStyle: TextStyle(color: ConstantColors.lightBlue03, height: 1.5, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Image.asset("assets/images/gift_box_icon.png"),
              const SizedBox(height: 20),
              Flexible(
                child: Text(
                  "Remember what user said earlier /n Allows user to provide follow-up corrections",
                  style: GoogleFonts.interTight(
                    textStyle: TextStyle(color: ConstantColors.lightBlue03, height: 1.5, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
