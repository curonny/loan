// ignore: file_names

import 'package:get/get.dart';
import 'package:loan/models/frecuencyModels.dart';
import 'package:dio/dio.dart' as dio_client;

import '../constant.dart';

class FrecuencyController extends GetxController {
  AppConstants appConstants = AppConstants();
  RxList frecuencyList = <Frecuency>[].obs;
  RxBool gettingFrecuencies = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getFrecuencies();
  }

  void setFrecuencies(List<Frecuency> list) {
    frecuencyList.value = list;
    update();
  }

  Future getFrecuencies() async {
    gettingFrecuencies.value = true;
    final dio = dio_client.Dio();
    List<Frecuency> list = [];
    var response = await dio.get(
      '${appConstants.apiBaseUrl}/frequency-catalog',
    );

    if (response.statusCode == 200) {
      final List data = response.data['frecuencies'];
      list = data
          .map((item) => Frecuency(
              name: item['name'],
              id: item['id'],
              paymentsPerYear: item['payments_per_year'],
              createdAt: DateTime.parse(item['createdAt']),
              updatedAt: DateTime.parse(item['updatedAt'])))
          .toList();
      print(list);
      setFrecuencies(list);
      gettingFrecuencies.value = false;
    }
    gettingFrecuencies.value = false;
  }
}
