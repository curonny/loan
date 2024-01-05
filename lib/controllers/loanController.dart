import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/models/frecuencyModels.dart';

import 'package:dio/dio.dart' as dio_client;
import 'package:loan/models/loanCreateModel.dart';
import 'package:loan/models/loanModel.dart';

import '../constant.dart';
import '../pages/loansPage.dart';

class LoanController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  late Frecuency frecuency;

  RxList<Loan> loansList = <Loan>[].obs;

  final selectedValue = TextEditingController();
  final amount = TextEditingController();
  final term = TextEditingController();
  final interestRate = TextEditingController();
  final openingCommission = TextEditingController();

  AppConstants appConstants = AppConstants();
  RxList frecuencyList = <Frecuency>[].obs;
  RxBool gettingFrecuencies = false.obs;

  RxBool loanCreated = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllLoans();
    await getFrecuencies();
  }

  void setFrecuencies(List<Frecuency> list) {
    frecuencyList.value = list;
    update();
  }

  void setLoans(List<Loan> list) {
    loansList.value = list;
    update();
  }

  getFrecuencyIdByName(String name) {
    final foundFrecuency =
        frecuencyList.firstWhereOrNull((frecuency) => frecuency.name == name);
    return foundFrecuency ?? -1;
  }

  Future getAllLoans() async {
    isLoading.value = true;
    final dio = dio_client.Dio();
    List<Loan> loanList = [];
    try {
      var response = await dio
          .get(
            '${appConstants.apiBaseUrl}/loans',
            options: dio_client.Options(
              receiveTimeout: const Duration(seconds: 10),
            ),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List data = response.data['loans'];
        loanList = data.map((item) => Loan.fromJson(item)).toList();
        setLoans(loanList);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Error getting loans",
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Error getting loans",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red);
    }
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
      '${appConstants.apiBaseUrl}/loans/quote/amount',
      data: jsonBody,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (response.statusCode == 201) {
      LoanDetails loan = LoanDetails.fromJson(response.data);
      loanCreated.value = true;

      Get.snackbar("Done", "Loan create sucessfully",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green);
    }
  }
}
