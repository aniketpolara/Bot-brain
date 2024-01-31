import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant/constant_colors.dart';
import '../controller/onboarding_controller.dart';
import '../utils/prafrences.dart';
import 'main_screen.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<OnBordingController>(
      init: OnBordingController(),
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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 34, right: 10),
                    child: InkWell(
                        onTap: () {
                          controller.pageController.jumpToPage(2);
                        },
                        child: controller.selectedPageIndex.value != 2
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Skip",
                                    style: GoogleFonts.interTight(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: ConstantColors.lightBlue03,
                                      ),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/border/right_line.svg",
                                    // ignore: deprecated_member_use
                                    color: ConstantColors.lightBlue03,
                                  )
                                ],
                              )
                            : const SizedBox(
                                height: 34,
                              ))),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.onBoardingList.length,
                    onPageChanged: controller.selectedPageIndex,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(controller.onBoardingList[index].image.toString()),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              controller.onBoardingList[index].text.toString(),
                              style: const TextStyle(
                                  color: Color(0xFfE6FEF8), fontSize: 32, fontFamily: "InstrumentSans", fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 43, right: 43, top: 15),
                            child: Text(
                              controller.onBoardingList[index].text1.toString(),
                              style: GoogleFonts.interTight(
                                textStyle: TextStyle(
                                  color: ConstantColors.assentBgTextAndBorder04,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: controller.onBoardingList.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                      activeDotColor: ConstantColors.primary03, dotColor: ConstantColors.lightBlue02, dotHeight: 8, dotWidth: 8),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: FilledButton.tonal(
                    onPressed: () {
                      controller.selectedPageIndex.value == 2
                          ? {Preferences.setBoolean(Preferences.isFinishOnBoardingKey, true), Get.offAll(const MainScreen())}
                          : controller.pageController.jumpToPage(controller.selectedPageIndex.value + 1);
                    },
                    style: FilledButton.styleFrom(backgroundColor: ConstantColors.primaryMain, minimumSize: const Size(263, 64)),
                    child: Text(
                      controller.selectedPageIndex.value == 2 ? "Get Started" : "Next",
                      style: GoogleFonts.interTight(
                        textStyle: TextStyle(color: ConstantColors.primary01, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
