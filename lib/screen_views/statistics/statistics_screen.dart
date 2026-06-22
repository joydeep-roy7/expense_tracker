import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/transaction_controller.dart';
import '../../data/models/transaction_model.dart';
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

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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

  List<double> getMonthlyIncome(List<TransactionModel> data) {
    List<double> monthly = List.filled(12, 0);

    for (var t in data) {
      if (t.type.toLowerCase() == "income") {
        monthly[t.date.month - 1] += t.amount;
      }
    }
    return monthly;
  }

  List<double> getMonthlyExpense(List<TransactionModel> data) {
    List<double> monthly = List.filled(12, 0);

    for (var t in data) {
      if (t.type.toLowerCase() == "expense") {
        monthly[t.date.month - 1] += t.amount;
      }
    }
    return monthly;
  }

  final months = const [
    "Jan","Feb","Mar","Apr","May","Jun",
    "Jul","Aug","Sep","Oct","Nov","Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xff5A2DDB),
        title: const Text(
          AppConstants.page3,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: GetBuilder<TransactionController>(
        builder: (_) {

          final data = controller.box.values.toList();

          final income = controller.totalIncome;
          final expense = controller.totalExpense;
          final total = income + expense;

          final incomePercent = total == 0 ? 0.0 : income / total;
          final expensePercent = total == 0 ? 0.0 : expense / total;

          final monthlyIncome = getMonthlyIncome(data);
          final monthlyExpense = getMonthlyExpense(data);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                /// ================= PIE CHART =================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [

                      const Text("Income vs Expense",
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 240,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, _) {
                            return PieChart(
                              PieChartData(
                                centerSpaceRadius: 50,
                                sectionsSpace: 4,
                                pieTouchData: PieTouchData(
                                  touchCallback: (event, response) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          response == null ||
                                          response.touchedSection == null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex =
                                          response.touchedSection!
                                              .touchedSectionIndex;
                                    });
                                  },
                                ),

                                sections: [
                                  PieChartSectionData(
                                    value: incomePercent * _animation.value,
                                    color: Colors.green,
                                    radius: touchedIndex == 0 ? 75 : 65,
                                    title:
                                    "${(incomePercent * 100).toStringAsFixed(1)}%",
                                    titleStyle: const TextStyle(
                                        color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    value: expensePercent * _animation.value,
                                    color: Colors.red,
                                    radius: touchedIndex == 1 ? 75 : 65,
                                    title:
                                    "${(expensePercent * 100).toStringAsFixed(1)}%",
                                    titleStyle: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= MONTHLY BAR CHART =================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text("Monthly Overview",
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 300,
                        child: BarChart(
                          BarChartData(
                            barGroups: List.generate(12, (i) {
                              return BarChartGroupData(
                                x: i,
                                barsSpace: 4,
                                barRods: [
                                  BarChartRodData(
                                    toY: monthlyIncome[i],
                                    color: Colors.green,
                                    width: 5,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  BarChartRodData(
                                    toY: monthlyExpense[i],
                                    color: Colors.red,
                                    width: 5,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ],
                              );
                            }),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      months[value.toInt()],
                                      style: const TextStyle(fontSize: 10),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= SUMMARY (FIXED NO OVERFLOW) =================
                Row(
                  children: [
                    Expanded(child: _mini("Income", income, Colors.green)),
                    const SizedBox(width: 10),
                    Expanded(child: _mini("Expense", expense, Colors.red)),
                  ],
                ),

                const SizedBox(height: 20),

                /// ================= SAVINGS =================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text("Savings Progress",
                          style: TextStyle(fontWeight: FontWeight.bold)),

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

  Widget _mini(String title, double value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 5),
          Text(
            "৳ ${value.toStringAsFixed(0)}",
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}