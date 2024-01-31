import 'package:bot_brain/constant/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ChatController>(
        init: ChatController(),
        builder: (controller) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                          "Bot Brain",
                          style:
                              TextStyle(color: ConstantColors.assentBGTextAndBorder06, fontSize: 24, fontFamily: "InstrumentSans", fontWeight: FontWeight.w700),
                        ),
                        PopupMenuButton<int>(
                          icon: Icon(
                            Icons.more_vert,
                            color: ConstantColors.assentBGTextAndBorder06,
                          ),
                          constraints: const BoxConstraints.expand(width: 150, height: 125),
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
                            PopupMenuItem(
                              value: 2,
                              child: Column(
                                children: [
                                  Divider(
                                    color: ConstantColors.primary02,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/border/Bin.svg",
                                          // ignore: deprecated_member_use
                                          color: ConstantColors.primary03,
                                        ),
                                        const SizedBox(width: 13),
                                        Text(
                                          "Clear All",
                                          style: GoogleFonts.interTight(
                                            textStyle: TextStyle(color: ConstantColors.primary03, fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          offset: const Offset(0, 55),
                          color: ConstantColors.primary01,
                          elevation: 2,
                          onSelected: (value) {
                            if (value == 1) {
                              controller.chatDataList.isNotEmpty ? Share.share(controller.shareData.value) : "";
                            } else if (value == 2) {
                              controller.chatDataList.clear();
                            }
                          },
                        ),
                      ],
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
                    controller.chatDataList.isEmpty
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/chat_icon.png"),
                                const SizedBox(height: 16),
                                Text(
                                  "Start chatting with our AI now!",
                                  style: TextStyle(
                                      color: ConstantColors.assentBGTextAndBorder06,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      height: 1.5,
                                      fontFamily: "InstrumentSans"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                                  child: Text(
                                    "Our chatbot is ready to engage in a conversation with you. Start chatting now and experience the power of AI",
                                    style: GoogleFonts.interTight(
                                      textStyle: TextStyle(
                                        color: ConstantColors.assentBgTextAndBorder05,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3,
                                        fontSize: 16,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.chatDataList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                        decoration: controller.chatDataList[index].isuser!
                                            ? const BoxDecoration()
                                            : BoxDecoration(
                                                color: ConstantColors.primary01,
                                                border: BorderDirectional(start: BorderSide(color: ConstantColors.primaryMain, width: 2))),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              controller.chatDataList[index].isuser! ? "assets/icons/fill/User.svg" : "assets/images/logo_bot.svg",
                                              // ignore: deprecated_member_use
                                              color: controller.chatDataList[index].isuser! ? ConstantColors.primaryMain : null,
                                              width: 32,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Obx(() => Expanded(
                                                    child: Padding(
                                                  padding: const EdgeInsets.only(top: 6.0),
                                                  child: Text(
                                                    controller.chatDataList[index].text.toString(),
                                                    style: GoogleFonts.interTight(
                                                        textStyle: TextStyle(
                                                            color: ConstantColors.assentBGTextAndBorder06, fontSize: 16, fontWeight: FontWeight.w500)),
                                                  ),
                                                ))),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ).paddingOnly(bottom: 100),
                          ),
                  ],
                ),
              ),
              bottomSheet: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                color: ConstantColors.primary01,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      height: 56,
                      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
                      decoration: BoxDecoration(color: ConstantColors.assentBgTextAndBorder03, borderRadius: BorderRadius.circular(36)),
                      child: TextFormField(
                        controller: controller.textEditingController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: "Send a message..",
                          hintStyle: GoogleFonts.interTight(
                            textStyle: GoogleFonts.interTight(
                              textStyle: TextStyle(color: ConstantColors.assentBgTextAndBorder04, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                        onTap: () {
                          if (controller.textEditingController.text.isEmpty) {
                            Get.snackbar(
                              maxWidth: MediaQuery.of(context).size.width * 0.51,
                              margin: const EdgeInsets.only(top: 10),
                              "Something went wrong ",
                              "Please Write Something...!",
                              backgroundColor: ConstantColors.red,
                              snackPosition: SnackPosition.TOP,
                              colorText: ConstantColors.primary06,
                              borderRadius: 10,
                            );
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.setSendDataList();
                          }
                        },
                        child: CircleAvatar(
                            backgroundColor: ConstantColors.primaryMain,
                            maxRadius: 25,
                            child: SvgPicture.asset(
                              "assets/icons/fill/send.svg",
                              // ignore: deprecated_member_use
                              color: ConstantColors.primary01,
                            ))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
