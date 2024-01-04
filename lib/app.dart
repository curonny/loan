import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:loan/pages/loans/loanPage.dart';

import 'controllers/loanController.dart';
import 'models/loanModel.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  LoanController get controller => Get.put(LoanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loans"),
        actions: [
          IconButton(
              onPressed: () async {
                await controller.getAllLoans();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.loansList.length,
              itemBuilder: (context, index) {
                Loan loan = controller.loansList[index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              "Opening commission: ${loan.openingCommission}"),
                          subtitle: Column(
                            children: [
                              Text(
                                  "Total interest amount: ${loan.totalInterestAmount}"),
                              Text(
                                  "Total payment amount: ${loan.totalPaymentAmount}"),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Amount: ${float.parse(loan.amount).toStringAsFixed(2)}"),
                                    Text("Term: ${loan.term}"),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Capacity discount: ${float.parse(loan.capacityDiscount).toStringAsFixed(2)}"),
                                    Text(
                                        "Interest rate: ${float.parse(loan.interestRate).toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )));
              },
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateLoanPage());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
