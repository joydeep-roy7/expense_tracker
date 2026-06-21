import 'package:expense_tracker/screen_views/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:expense_tracker/screen_views/transaction/add_transaction_screen.dart';
import 'package:expense_tracker/screen_views/transaction/transaction_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/transaction_controller.dart';

void main() async {

  Get.put(TransactionController());

  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BottomNavigationBarState(),
      home: TransactionListScreen(),
    );
  }
}
