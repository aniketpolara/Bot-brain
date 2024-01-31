import 'package:bot_brain/controller/dashbord_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constant/constant_colors.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DashbordController>(
        init: DashbordController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [Flexible(child: controller.bottombarlist[controller.changeindex])],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: ConstantColors.primaryMain,
                  unselectedItemColor: ConstantColors.assentBgTextAndBorder04,
                  showUnselectedLabels: true,
                  onTap: controller.tapbottombar,
                  currentIndex: controller.changeindex,
                  items: [
                    BottomNavigationBarItem(
                      icon: controller.changeindex == 0
                          // ignore: deprecated_member_use
                          ? SvgPicture.asset("assets/icons/fill/home.svg", color: ConstantColors.primaryMain)
                          : SvgPicture.asset("assets/icons/border/home.svg", color: ConstantColors.assentBgTextAndBorder04),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: controller.changeindex == 1
                          // ignore: deprecated_member_use
                          ? SvgPicture.asset("assets/icons/fill/chat-1.svg", color: ConstantColors.primaryMain)
                          // ignore: deprecated_member_use
                          : SvgPicture.asset("assets/icons/border/chat.svg", color: ConstantColors.assentBgTextAndBorder04),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: controller.changeindex == 2
                          // ignore: deprecated_member_use
                          ? SvgPicture.asset("assets/icons/fill/code.svg", color: ConstantColors.primaryMain)
                          // ignore: deprecated_member_use
                          : SvgPicture.asset("assets/icons/fill/code.svg", color: ConstantColors.assentBgTextAndBorder04),
                      label: 'Code',
                    ),
                  ]),
            ),
          );
        });
  }
}
