import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/controllers/loanController.dart';
import 'package:loan/pages/loansPage.dart';

class CreateLoanPage extends StatefulWidget {
  const CreateLoanPage({super.key});

  @override
  State<CreateLoanPage> createState() => _CreateLoanPageState();
}

class _CreateLoanPageState extends State<CreateLoanPage> {
  LoanController get controller => Get.put(LoanController());
  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = [];
    for (var frecuency in controller.frecuencyList) {
      dropdownItems.add(frecuency.name.toString());
    }
    controller.frecuencyList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
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
        child: Column(
          children: [
            Obx(() => controller.gettingFrecuencies.value
                ? CircularProgressIndicator()
                : Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Obx(
                                () => controller.frecuencyList.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DropdownSearch<String>(
                                        popupProps: const PopupProps.menu(
                                          title: Text("Buscar"),
                                          showSelectedItems: true,
                                          showSearchBox: true,
                                        ),
                                        items: controller.frecuencyList
                                            .map((element) =>
                                                element.name.toString())
                                            .toList(),
                                        filterFn: (item, filter) =>
                                            item.contains(filter.toUpperCase()),
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            labelText: "Select frecuency",
                                            hintText: "Select frecuency",
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.selectedValue.text =
                                              value.toString();
                                        },
                                        //show selected item
                                        selectedItem: "Seleccionar",
                                      ),
                              ),
                              TextFormField(
                                controller: controller.amount,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(labelText: 'Amount'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.term,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(labelText: 'Term'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.interestRate,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: 'Interest Rate'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.openingCommission,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: 'Opening Commission'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the term';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.formKey.currentState
                                          ?.validate() ??
                                      false) {
                                    controller.doLoan();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Bordes redondeados
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0), // Padding vertical
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 18.0), // Tamaño del texto
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )),
            Obx(() => controller.loanCreated.value
                ? IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 1));
                      Get.offAll(HomePage());
                    },
                    icon: Icon(Icons.home))
                : SizedBox())
          ],
        ),
      ),
    );
  }
}
