import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/pages/loans/loanPage.dart';

import 'controllers/loanController.dart';

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
      ),
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
