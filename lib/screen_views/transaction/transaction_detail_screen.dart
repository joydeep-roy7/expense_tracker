import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/transaction_controller.dart';
import '../../data/models/transaction_model.dart';
import 'edit_transaction_screen.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;
  final dynamic keyValue;

  TransactionDetailScreen({
    super.key,
    required this.transaction,
    required this.keyValue,
  });

  final TransactionController controller = Get.find<TransactionController>();

  void deleteTransaction() {
    Get.defaultDialog(
      title: "Delete Transaction",
      titleStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),

      middleText: "Are you sure you want to delete this transaction?",
      middleTextStyle: const TextStyle(color: Colors.black87),

      backgroundColor: Colors.white,
      radius: 12,
      contentPadding: const EdgeInsets.all(20),

      textConfirm: null,
      textCancel: null,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// CANCEL BUTTON
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Cancel"),
            ),

            const SizedBox(width: 10),

            /// DELETE BUTTON
            ElevatedButton(
              onPressed: () {
                controller.removeTransaction(keyValue);

                Get.back();
                Get.back();

                Get.snackbar(
                  "Deleted",
                  "Transaction removed successfully",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type.toLowerCase() == "income";

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xff5A2DDB),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Transaction Details",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// MAIN CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// ICON
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: isIncome
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.red.withValues(alpha: 0.15),
                      child: Icon(
                        isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 35,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// TITLE
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isIncome
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        transaction.type.toUpperCase(),
                        style: TextStyle(
                          color: isIncome ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// AMOUNT
                    Text(
                      "${isIncome ? '+' : '-'} ৳${transaction.amount.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// DATE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          DateFormat(
                            "dd MMM yyyy, hh:mm a",
                          ).format(transaction.date),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// NOTE
                    if (transaction.note != null &&
                        transaction.note!.isNotEmpty)
                      Column(
                        children: [
                          const Divider(),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Note",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              transaction.note!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ACTION BUTTONS
              Row(
                children: [
                  /// EDIT
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(
                          () => EditTransactionScreen(
                            transaction: transaction,
                            keyValue: keyValue,
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// DELETE
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: deleteTransaction,
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
