import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/controllers/loanController.dart';

import '../../controllers/frecuencyController.dart';

class CreateLoanPage extends StatefulWidget {
  const CreateLoanPage({super.key});

  @override
  State<CreateLoanPage> createState() => _CreateLoanPageState();
}

class _CreateLoanPageState extends State<CreateLoanPage> {
  FrecuencyController get controller => Get.put(FrecuencyController());
  LoanController get loanController => Get.put(LoanController());
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    dropdownItems.add(DropdownMenuItem(
      key: Key(0.toString()),
      child: const Text("Select frecuency"),
    ));
    print(controller.frecuencyList.length);
    for (var frecuency in controller.frecuencyList) {
      dropdownItems.add(DropdownMenuItem(
        key: Key(frecuency.id.toString()),
        child: Text(frecuency.name),
      ));
    }
    dropdownItems.add(DropdownMenuItem(
      key: Key(9999.toString()),
      child: const Text("Select frecuency1"),
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create loan"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Obx(() => controller.gettingFrecuencies.value &&
                  controller.frecuencyList.isNotEmpty
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: DropdownButton(
                    items: dropdownItems,
                    onChanged: (String? value) {
                      print(value);

                      // loanController.setSelectionFrecuencyId(value);
                    },
                  ),
                ))
        ]),
      ),
    );
  }
}
