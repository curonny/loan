// ignore_for_file: file_names

import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt currectIndex = 0.obs;

  setCurrentIndex(int index) {
    currectIndex.value = index;
    update();
  }
}
