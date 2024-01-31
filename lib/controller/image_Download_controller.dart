import 'dart:io';

import 'package:bot_brain/constant/constant_colors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDownloadController extends GetxController {
  final RxString url = ''.obs;
  Permission? permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  download(String imageUrl) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> status;

    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt <= 32) {
        status = await [Permission.storage].request();
      } else {
        status = await [Permission.photos].request();
      }
    } else {
      status = await [Permission.photosAddOnly].request();
    }

    var allAccept = true;
    status.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccept = false;
      }
    });

    if (allAccept) {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      url.value = imageUrl;
      var response = await Dio().get(url.value, options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: "probot");
      await EasyLoading.dismiss();
      Get.snackbar(
        'Success',
        "Image Downloaded Successfully",
        snackPosition: SnackPosition.TOP,
        colorText: ConstantColors.primary03,
        backgroundColor: ConstantColors.primary06,
        borderRadius: 10,
        boxShadows: [
          BoxShadow(color: ConstantColors.primary01, blurRadius: 5, spreadRadius: 1, offset: const Offset(4, 4)),
        ],
      );
    } else {
      await EasyLoading.dismiss();
      Get.snackbar(
        'Alert!',
        "Something Went Wrong",
        backgroundColor: ConstantColors.red,
        snackPosition: SnackPosition.TOP,
        colorText: ConstantColors.primary06,
        borderRadius: 10,
      );
    }
  }
}
