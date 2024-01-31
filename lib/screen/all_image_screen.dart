import 'package:bot_brain/constant/constant_colors.dart';
import 'package:bot_brain/model/image_mode.dart';
import 'package:bot_brain/screen/full_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllImageScreen extends StatefulWidget {
  final List<ImageData> imageList;

  const AllImageScreen({Key? key, required this.imageList}) : super(key: key);

  @override
  State<AllImageScreen> createState() => _AllImageScreenState();
}

class _AllImageScreenState extends State<AllImageScreen> {
  List<ImageData>? imageList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: imageList!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Get.to(ImageView(
                        imageList: imageList!,
                        index: index,
                      ));
                    },
                    child: InkResponse(
                      enableFeedback: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ConstantColors.assentBgTextAndBorder01,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageList![index].url.toString(),
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ));
              },
            ).paddingOnly(left: 10, right: 10),
          ],
        ).paddingOnly(top: 10, bottom: 10),
      ),
    );
  }

  @override
  void initState() {
    imageList = widget.imageList;
    super.initState();
  }
}
