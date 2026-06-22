import 'package:expense_tracker/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../../controllers/transaction_controller.dart';
import '../../utils/app_constants.dart';
import 'add_transaction_screen.dart';
import 'transaction_detail_screen.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final TransactionController controller = Get.find<TransactionController>();

  String selectedFilter = "All";
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xff5A2DDB),
        title: const Text(
          AppConstants.page1,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Wrap(
                    children: [
                      ListTile(
                        title: const Text("All"),
                        onTap: () {
                          setState(() => selectedFilter = "All");
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: const Text("Income"),
                        onTap: () {
                          setState(() => selectedFilter = "Income");
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: const Text("Expense"),
                        onTap: () {
                          setState(() => selectedFilter = "Expense");
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
          ),
        ],
      ),

      body: GetBuilder<TransactionController>(
        builder: (_) {
          var transactions = controller.box.values;

          List<TransactionModel> transactions =
          controller.box.values.toList();

          if (selectedFilter != "All") {
            transactions = transactions
                .where(
                  (e) => e.type.toLowerCase() == selectedFilter.toLowerCase(),
                )
                .toList();
          }

          if (searchText.isNotEmpty) {
            transactions = transactions
                .where(
                  (e) =>
                      e.title.toLowerCase().contains(searchText.toLowerCase()),
                )
                .toList();
          }

          return Column(
            children: [
              /// SEARCH
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) => setState(() => searchText = value),
                  decoration: InputDecoration(
                    hintText: "Search transactions...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              /// FILTER + ADD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _filterButton("All"),
                        const SizedBox(width: 10),
                        _filterButton("Income"),
                        const SizedBox(width: 10),
                        _filterButton("Expense"),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => const AddTransactionScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A2DDB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text("Add Transaction"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// LIST
              Expanded(
                child: transactions.isEmpty
                    ? const Center(child: Text("No Transactions Found"))
                    : ValueListenableBuilder<Box>(
                      valueListenable: controller.box.listenable(),
                      builder: (context, value, child) {
                        return ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 20,
                            ),
                          itemCount: transactions.length,
                            itemBuilder: (context, index) {

                              final transaction = transactions[index];

                              final currentDate = DateFormat(
                                "dd MMM yyyy",
                              ).format(transaction.date);
                        
                              final prevDate = index > 0
                                  ? DateFormat(
                                      "dd MMM yyyy",
                                    ).format(transactions[index - 1].date)
                                  : "";
                        
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (index == 0 || currentDate != prevDate)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        currentDate,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                        
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                            () => TransactionDetailScreen(
                                              transaction: transaction,
                                              keyValue: transaction.key,
                                            )
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color:
                                                  transaction.type.toLowerCase() ==
                                                      "income"
                                                  ? Colors.green.withValues(
                                                      alpha: 0.15,
                                                    )
                                                  : Colors.red.withValues(
                                                      alpha: 0.15,
                                                    ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              transaction.type.toLowerCase() ==
                                                      "income"
                                                  ? Icons.arrow_upward
                                                  : Icons.arrow_downward,
                                              color:
                                                  transaction.type.toLowerCase() ==
                                                      "income"
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                        
                                          const SizedBox(width: 12),
                        
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  transaction.title,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  transaction.type,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                        
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${transaction.type.toLowerCase() == "income" ? "+" : "-"} ৳${transaction.amount.toStringAsFixed(0)}",
                                                style: TextStyle(
                                                  color:
                                                      transaction.type
                                                              .toLowerCase() ==
                                                          "income"
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                DateFormat(
                                                  "hh:mm a",
                                                ).format(transaction.date),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                      }
                    ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterButton(String title) {
    final isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() => selectedFilter = title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff5A2DDB) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
