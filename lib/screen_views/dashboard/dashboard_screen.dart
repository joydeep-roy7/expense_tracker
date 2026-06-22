import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/transaction_controller.dart';
import '../../data/models/transaction_model.dart';
import '../../utils/app_constants.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DashboardScreen extends StatefulWidget {
  final NotchBottomBarController notchController;

  const DashboardScreen({super.key, required this.notchController});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TransactionController controller = Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      // drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          AppConstants.page2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Symbols.app_badging, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),

      body: GetBuilder<TransactionController>(
        builder: (_) {
          final List<TransactionModel> transactions = controller.box.values
              .toList();

          transactions.sort((a, b) => b.date.compareTo(a.date));

          final recent = transactions.take(5).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                /// HEADER
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C63FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "👋 Welcome back,",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Expense Tracker",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// BALANCE CARD
                Transform.translate(
                  offset: const Offset(0, -90),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Symbols.wallet, color: Color(0xFF6C63FF)),
                              SizedBox(width: 10),
                              Text(
                                "Total Balance",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Text(
                            "৳ ${controller.totalBalance.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _incomeExpense(
                                Icons.arrow_upward,
                                Colors.green,
                                "Income",
                                "৳ ${controller.totalIncome.toStringAsFixed(0)}",
                              ),
                              _incomeExpense(
                                Icons.arrow_downward,
                                Colors.red,
                                "Expense",
                                "৳ ${controller.totalExpense.toStringAsFixed(0)}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// RECENT HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: transactions.length,
                                itemBuilder: (context, index) {
                                  final t = transactions[index];
                                  return ListTile(
                                    title: Text(t.title),
                                    subtitle: Text(t.type),
                                    trailing: Text(
                                      "৳ ${t.amount.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        color: t.type.toLowerCase() == "income"
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            isScrollControlled: true,
                          );
                        },
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// RECENT LIST
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: recent.isEmpty
                      ? const Column(
                          children: [
                            Icon(Symbols.wallet, size: 60, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              "No transactions yet",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: recent.map((t) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        t.type.toLowerCase() == "income"
                                        ? Colors.green.withValues(alpha: 0.2)
                                        : Colors.red.withValues(alpha: 0.2),
                                    child: Icon(
                                      t.type.toLowerCase() == "income"
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color: t.type.toLowerCase() == "income"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(t.title)),
                                  Text(
                                    "৳ ${t.amount.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      color: t.type.toLowerCase() == "income"
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),

                const SizedBox(height: 70),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget _incomeExpense(
    IconData icon,
    Color color,
    String title,
    String amount,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
