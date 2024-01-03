// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/controllers/frecuencyController.dart';

class LoanController extends GetxController {
  FrecuencyController frecuencyController = FrecuencyController();
  RxInt frecuencyId = 0.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  final amount = TextEditingController();
  final term = TextEditingController();
  final interestRate = TextEditingController();
  final openingCommission = TextEditingController();

  setSelectionFrecuencyId(value) {
    final matchingElement = frecuencyController.frecuencyList.firstWhere(
      (element) => element.name == value,
      orElse: () => null,
    );

    if (matchingElement != null) {
      frecuencyId.value = matchingElement.id;
    } else {
      print("No se encontró un elemento con el valor $value");
    }
    update();
  }
}
