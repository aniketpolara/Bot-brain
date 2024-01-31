import 'package:bot_brain/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../constant/constant_colors.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({Key? key}) : super(key: key);

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
                          style: TextStyle(fontFamily: "InstrumentSans", color: ConstantColors.primaryMain, fontWeight: FontWeight.w700, fontSize: 24),
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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Container(
                        height: 80,
                        width: 358,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.4),
                          color: ConstantColors.assentBgTextAndBorder01,
                          border: Border.all(color: ConstantColors.assentBgTextAndBorder03, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                "Look for 5 potential headlines for websites with fintech themes",
                                style: GoogleFonts.interTight(
                                    textStyle: TextStyle(
                                      color: ConstantColors.assentBGTextAndBorder06,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    height: 1.5),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: ConstantColors.assentBgTextAndBorder05,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
