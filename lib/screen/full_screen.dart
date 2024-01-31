import 'dart:developer';
import 'dart:io';

import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/controller/image_Download_controller.dart';
import 'package:bot_brain/model/image_mode.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageView extends StatefulWidget {
  final int index;
  final List<ImageData> imageList;

  const ImageView({super.key, required this.index, required this.imageList});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final CarouselController _controller = CarouselController();
  ImageDownloadController imageController = ImageDownloadController();

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = widget.index;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.primary06,
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    http.Response response = await http.get(Uri.parse(widget.imageList[_currentIndex].url.toString()));

                    final directory = await getTemporaryDirectory();
                    final path = directory.path;
                    final file = File('$path/image.png');
                    file.writeAsBytes(response.bodyBytes);
                    // ignore: deprecated_member_use
                    Share.shareFiles(['$path/image.png']);
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/fill/share.svg',
                    // ignore: deprecated_member_use
                    color: ConstantColors.primary06,
                  )),
              IconButton(
                  onPressed: () {
                    imageController.download(widget.imageList[_currentIndex].url.toString());
                    log(widget.imageList[_currentIndex].url.toString());
                  },
                  icon: Icon(
                    Icons.download,
                    color: ConstantColors.primary06,
                  )),
            ],
          ),
        )
      ]),
      body: Stack(
        children: <Widget>[
          Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return CarouselSlider(
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  initialPage: _currentIndex,
                  onPageChanged: (index, reason) {
                    _currentIndex = index;
                    setState(() {});
                  },
                  // autoPlay: false,
                ),
                carouselController: _controller,
                items: widget.imageList
                    .map((item) => Center(
                        child: CachedNetworkImage(
                            imageUrl: item.url.toString(),
                            fit: BoxFit.none,
                            height: height,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()))))
                    .toList(),
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () async {
                      imageController.download(widget.imageList[_currentIndex].url.toString());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ConstantColors.primary01,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.download, color: Colors.white),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Download'.tr,
                            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
