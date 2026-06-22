import 'package:expense_tracker/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../controllers/transaction_controller.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TransactionController controller = Get.find<TransactionController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String selectedType = "Income";
  DateTime selectedDate = DateTime.now();

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void saveTransaction() {
    if (titleController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Title and Amount are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final transactionDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      DateTime.now().hour,
      DateTime.now().minute,
    );

    final amount = double.tryParse(amountController.text.trim());

    if (amount == null) {
      Get.snackbar(
        "Error",
        "Enter valid amount",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    controller.addTransaction(
      TransactionModel(
        title: titleController.text.trim(),
        amount: amount,
        type: selectedType,
        date: transactionDate,
        note: noteController.text.trim(),
      ),
    );

    Get.back();

    Get.snackbar(
      "Success",
      "Transaction Added",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff5A2DDB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Add Transaction",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Income / Expense
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = "Income";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == "Income"
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: selectedType == "Income"
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = "Expense";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == "Expense"
                                ? Colors.red
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: selectedType == "Expense"
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Icon
              CircleAvatar(
                radius: 32,
                backgroundColor: selectedType == "Income"
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.red.withValues(alpha: 0.15),
                child: Icon(
                  selectedType == "Income"
                      ? Symbols.trending_up
                      : Symbols.trending_down,
                  color: selectedType == "Income" ? Colors.green : Colors.red,
                  size: 40,
                ),
              ),

              const SizedBox(height: 25),

              /// Title
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "e.g. Salary, Freelance",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Amount
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "Enter amount",
                  suffixText: "৳",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Date
              GestureDetector(
                onTap: pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat('dd MMM, yyyy').format(selectedDate),
                        ),
                      ),
                      const Icon(Symbols.calendar_month),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Note
              TextField(
                controller: noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Note (Optional)",
                  hintText: "Add a note",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (titleController.text.trim().isEmpty ||
                      amountController.text.trim().isEmpty)
                      ? null
                      : saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A2DDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Save Transaction",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
