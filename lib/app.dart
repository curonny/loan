import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan/controllers/appController.dart';
import 'package:loan/pages/loansPage.dart';

import 'pages/settingsPage.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppController get appController => Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      const SettingPage(),
    ];
    return Scaffold(
      body: Obx(() => screens[appController.currectIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: appController.currectIndex.value,
            onTap: (index) {
              appController.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          )),
    );
  }
}
