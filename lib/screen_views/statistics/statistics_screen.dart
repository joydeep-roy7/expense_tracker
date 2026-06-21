import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/transaction_controller.dart';
import '../../utils/app_constants.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<TransactionController>();

  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xff5A2DDB),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppConstants.page3,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: GetBuilder<TransactionController>(
        builder: (_) {
          double income = controller.totalIncome;
          double expense = controller.totalExpense;
          double total = income + expense;

          double incomePercent = total == 0 ? 0 : (income / total);
          double expensePercent = total == 0 ? 0 : (expense / total);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ================= PIE CHART (ANIMATED) =================
                _glassCard(
                  child: Column(
                    children: [
                      const Text(
                        "Income vs Expense",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        height: 240,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, _) {
                            return PieChart(
                              PieChartData(
                                startDegreeOffset: -90,
                                centerSpaceRadius: 55,
                                sectionsSpace: 3,
                                sections: [
                                  PieChartSectionData(
                                    value: incomePercent * _animation.value,
                                    color: Colors.green,
                                    radius: 70,
                                    title:
                                    "${(incomePercent * 100 * _animation.value).toStringAsFixed(1)}%",
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: expensePercent * _animation.value,
                                    color: Colors.red,
                                    radius: 70,
                                    title:
                                    "${(expensePercent * 100 * _animation.value).toStringAsFixed(1)}%",
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legend(Colors.green, "Income"),
                          const SizedBox(width: 20),
                          _legend(Colors.red, "Expense"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= MONTHLY ANALYTICS =================
                // _glassCard(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         "Monthly Analytics",
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //
                //       const SizedBox(height: 20),
                //
                //       _buildBar("Jan", 0.6),
                //       _buildBar("Feb", 0.4),
                //       _buildBar("Mar", 0.8),
                //       _buildBar("Apr", 0.3),
                //       _buildBar("May", 0.7),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 20),

                /// ================= SUMMARY =================
                Row(
                  children: [
                    Expanded(
                      child: _miniCard(
                        "Income",
                        income,
                        Colors.green,
                        Icons.arrow_downward,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _miniCard(
                        "Expense",
                        expense,
                        Colors.red,
                        Icons.arrow_upward,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// ================= SAVINGS =================
                _glassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Savings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      LinearProgressIndicator(
                        value: total == 0 ? 0 : income / total,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.blue,
                        minHeight: 10,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Saved ${(income - expense).toStringAsFixed(0)} ৳ this month",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
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

  /// ================= BAR (MONTHLY ANALYTICS) =================
  // Widget _buildBar(String month, double value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 6),
  //     child: Row(
  //       children: [
  //         SizedBox(width: 40, child: Text(month)),
  //         Expanded(
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(10),
  //             child: TweenAnimationBuilder<double>(
  //               tween: Tween(begin: 0, end: value),
  //               duration: const Duration(milliseconds: 800),
  //               builder: (context, val, _) {
  //                 return LinearProgressIndicator(
  //                   value: val,
  //                   minHeight: 10,
  //                   backgroundColor: Colors.grey.shade200,
  //                   color: Colors.deepPurple,
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 10),
  //         Text("${(value * 100).toInt()}%"),
  //       ],
  //     ),
  //   );
  // }

  /// ================= CARD =================
  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
          ),
        ],
      ),
      child: child,
    );
  }

  /// ================= MINI CARD =================
  Widget _miniCard(
      String title,
      double value,
      Color color,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 10),
          Text(title),
          const SizedBox(height: 5),
          Text(
            "৳ ${value.toStringAsFixed(0)}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _legend(Color color, String title) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(title),
      ],
    );
  }
}