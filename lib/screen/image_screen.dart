import 'dart:developer';

import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/controller/image_controller.dart';
import 'package:bot_brain/screen/all_image_screen.dart';
import 'package:bot_brain/screen/full_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ImageController>(
        init: ImageController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                          constraints: const BoxConstraints.expand(width: 145, height: 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Column(
                                children: [
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
                          onSelected: (value) async {
                            if (value == 1) {
                              controller.imageList.clear();
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          controller.imageList.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/fill/User.svg",
                                        height: 32,
                                        width: 32,
                                        // ignore: deprecated_member_use
                                        color: ConstantColors.primaryMain,
                                      ),
                                      const SizedBox(width: 26),
                                      Flexible(
                                          child: Text(
                                        controller.chatDataList[0].text.toString(),
                                        style: TextStyle(color: ConstantColors.primary06, fontSize: 16),
                                      )),
                                    ],
                                  ),
                                ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: ConstantColors.primary01, border: Border(left: BorderSide(color: ConstantColors.primaryMain))),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/logo.svg",
                                  height: 22,
                                  width: 32,
                                ),
                                const SizedBox(width: 16),
                                Obx(() => controller.imageList.isEmpty
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.78,
                                            child: Text(
                                              "Convert words to images in seconds with Bot Brain free AI image generator. Input the text prompts and transfer your imagination into arts now. ",
                                              style: TextStyle(color: ConstantColors.assentBgTextAndBorder05, fontSize: 16),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                            color: ConstantColors.primary06,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            "Select Size",
                                            style: TextStyle(
                                              color: ConstantColors.assentBgTextAndBorder05,
                                            ),
                                          ).paddingOnly(bottom: 8),
                                          Wrap(children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 16.64,
                                                  height: 16.64,
                                                  child: Radio(
                                                    autofocus: true,
                                                    value: "256x256",
                                                    activeColor: ConstantColors.primaryMain,
                                                    groupValue: controller.genderRadioBtnVal.value,
                                                    onChanged: (value) {
                                                      controller.genderRadioBtnVal.value = value.toString();
                                                      log(controller.genderRadioBtnVal.value);
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                                  child: Text("256x256",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: controller.genderRadioBtnVal.value == "256x256"
                                                              ? ConstantColors.primary06
                                                              : ConstantColors.assentBgTextAndBorder04)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 16.64,
                                                  height: 16.64,
                                                  child: Radio(
                                                    value: "512x512",
                                                    activeColor: ConstantColors.primaryMain,
                                                    groupValue: controller.genderRadioBtnVal.value,
                                                    onChanged: (value) {
                                                      controller.genderRadioBtnVal.value = value.toString();
                                                      log(controller.genderRadioBtnVal.value);
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                                  child: Text("512x512",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: controller.genderRadioBtnVal.value == "512x512"
                                                              ? ConstantColors.primary06
                                                              : ConstantColors.assentBgTextAndBorder04)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 16.64,
                                                  height: 16.64,
                                                  child: Radio(
                                                    value: "1024x1024",
                                                    activeColor: ConstantColors.primaryMain,
                                                    groupValue: controller.genderRadioBtnVal.value,
                                                    onChanged: (value) {
                                                      controller.genderRadioBtnVal.value = value.toString();
                                                      log(controller.genderRadioBtnVal.value);
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text("1024x1024",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: controller.genderRadioBtnVal.value == "1024x1024"
                                                              ? ConstantColors.primary06
                                                              : ConstantColors.assentBgTextAndBorder04)),
                                                ),
                                              ],
                                            )
                                          ]),
                                        ],
                                      )
                                    : Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    controller.chatDataList[1].text.toString(),
                                                    style: TextStyle(color: ConstantColors.primary06, fontSize: 16),
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Get.to(AllImageScreen(imageList:controller.imageList,));
                                                    },
                                                    child: Text(
                                                      "See all",
                                                      style: TextStyle(color: ConstantColors.primaryMain, fontSize: 16),
                                                    ))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: ConstantColors.lightBlue02,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            GridView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context, int index) {
                                                return InkWell(
                                                    onTap: () {
                                                      Get.to(ImageView(
                                                        imageList: controller.imageList,
                                                        index: index,
                                                      ));
                                                    },
                                                    child: InkResponse(
                                                      enableFeedback: true,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            color: ConstantColors.assentBgTextAndBorder01,),
                                                        child: CachedNetworkImage(
                                                          imageUrl: controller.imageList[index].url.toString(),
                                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ));
                                              },
                                            ).paddingOnly(left: 10, right: 10),
                                          ],
                                        ),
                                      )),
                              ],
                            ),
                          ).paddingOnly(bottom: 100)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomSheet: Container(
                width: MediaQuery.of(context).size.width,
                color: ConstantColors.primary01,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(color: ConstantColors.assentBgTextAndBorder03, borderRadius: BorderRadius.circular(36)),
                      child: TextFormField(
                        maxLines: 1,
                        controller: controller.imageTextController.value,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: "Send a message.",
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
                        if (controller.imageTextController.value.text.isEmpty) {
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
                          controller.searchImage();
                        }
                      },
                      child: CircleAvatar(
                          backgroundColor: ConstantColors.primaryMain,
                          maxRadius: 25,
                          child: SvgPicture.asset(
                            "assets/icons/fill/send.svg",
                            // ignore: deprecated_member_use
                            color: ConstantColors.primary01,
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
