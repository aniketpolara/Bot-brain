import 'package:bot_brain/screen/chat_screen.dart';
import 'package:bot_brain/screen/code_screen.dart';
import 'package:bot_brain/screen/home_screen.dart';
import 'package:get/get.dart';

class DashbordController extends GetxController {
  List bottombarlist = [const HomeScreen(), const ChatScreen(), const CodeScreen()];

  final _changeindex = 0.obs;
  int get changeindex => _changeindex.value;
  set changeindex(int value) => _changeindex.value = value;

  tapbottombar(int i) {
    i == 1
        ? Get.to(const ChatScreen())
        : i == 2
            ? Get.to(const CodeScreen())
            : changeindex = i;
  }
}
