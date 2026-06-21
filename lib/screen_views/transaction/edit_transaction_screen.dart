import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/transaction_controller.dart';
import '../../data/models/transaction_model.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;
  final int index;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
    required this.index,
  });

  @override
  State<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final TransactionController controller = Get.find();

  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController noteController;

  String selectedType = "Income";

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.transaction.title);

    amountController =
        TextEditingController(text: widget.transaction.amount.toString());

    noteController =
        TextEditingController(text: widget.transaction.note ?? "");

    selectedType = widget.transaction.type;
  }

  void updateTransaction() {
    if (titleController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Title & Amount required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final updated = TransactionModel(
      title: titleController.text.trim(),
      amount: double.parse(amountController.text.trim()),
      type: selectedType,
      date: widget.transaction.date,
      note: noteController.text.trim(),
    );

    controller.updateTransaction(widget.index, updated);

    Get.back();
    Get.snackbar(
      "Success",
      "Transaction Updated",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// APPBAR (same as Add screen)
      appBar: AppBar(
        backgroundColor: const Color(0xff5A2DDB),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Transaction",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              /// INCOME / EXPENSE TOGGLE
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
                          setState(() => selectedType = "Income");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == "Income"
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Income",
                              style: TextStyle(
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
                          setState(() => selectedType = "Expense");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == "Expense"
                                ? Colors.red
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Expense",
                              style: TextStyle(
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

              /// ICON
              CircleAvatar(
                radius: 32,
                backgroundColor: selectedType == "Income"
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.red.withValues(alpha: 0.15),
                child: Icon(
                  selectedType == "Income"
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: selectedType == "Income"
                      ? Colors.green
                      : Colors.red,
                  size: 40,
                ),
              ),

              const SizedBox(height: 25),

              /// TITLE
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

              /// AMOUNT
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  suffixText: "৳",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// NOTE
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Note (Optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: updateTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A2DDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Update Transaction",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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