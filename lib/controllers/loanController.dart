import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/models/frecuencyModels.dart';

import 'package:dio/dio.dart' as dio_client;

import '../constant.dart';

class LoanController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  late Frecuency frecuency;

  final selectedValue = TextEditingController();
  final amount = TextEditingController();
  final term = TextEditingController();
  final interestRate = TextEditingController();
  final openingCommission = TextEditingController();

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

  getFrecuencyIdByName(String name) {
    final foundFrecuency =
        frecuencyList.firstWhereOrNull((frecuency) => frecuency.name == name);
    return foundFrecuency ?? -1;
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
      setFrecuencies(list);

      gettingFrecuencies.value = false;
    }
    gettingFrecuencies.value = false;
  }

  doLoan() async {
    final frecuencyId = getFrecuencyIdByName(selectedValue.text);
    // ignore: unnecessary_null_comparison
    if (frecuencyId == -1) {
      Get.snackbar("Invalid frecuency selected", "Wrong data",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red);
    }
    print(frecuencyId.paymentsPerYear);

    isLoading.value = true;
    Map<String, dynamic> jsonBody = {
      'amount': amount.value.text.trim(),
      'frequency_id': frecuencyId.id,
      "term": term.value.text.trim(),
      "interest_rate": interestRate.value.text.trim(),
      "opening_commission": openingCommission.value.text.trim()
    };
    final dio = dio_client.Dio();
    var response = await dio.post(
      '${appConstants.apiBaseUrl}/loans/quote',
      data: jsonBody,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    print(response);
  }
}
