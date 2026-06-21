import 'package:expense_tracker/data/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TransactionController extends GetxController {
  late Box box;

  List<TransactionModel> transactionData = [];

  @override
  void onInit() {
    super.onInit();
    box = Hive.box('transactions');
    loadTransactions();
  }

  /// LOAD DATA
  void loadTransactions() {
    transactionData =
        box.values.cast<TransactionModel>().toList().reversed.toList();
    update();
  }

  /// ADD
  void addTransaction(TransactionModel transaction) {
    box.add(transaction);
    loadTransactions();

    // Get.snackbar(
    //   "Success",
    //   "Transaction added",
    //   backgroundColor: const Color(0xff4CAF50),
    //   colorText: const Color(0xffFFFFFF),
    // );
  }

  /// DELETE
  void removeTransaction(int index) {
    final realIndex = box.length - 1 - index;
    box.deleteAt(realIndex);
    loadTransactions();

    // Get.snackbar(
    //   "Deleted",
    //   "Transaction removed",
    //   backgroundColor: const Color(0xffF44336),
    //   colorText: const Color(0xffFFFFFF),
    // );
  }

  /// UPDATE
  void updateTransaction(int index, TransactionModel transaction) {
    final realIndex = box.length - 1 - index;
    box.putAt(realIndex, transaction);
    loadTransactions();

    // Get.snackbar(
    //   "Updated",
    //   "Transaction updated successfully",
    //   backgroundColor: const Color(0xffFF9800),
    //   colorText: const Color(0xffFFFFFF),
    // );
  }

  /// CALCULATIONS
  double get totalIncome {
    return transactionData
        .where((t) => t.type.toLowerCase() == "income")
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return transactionData
        .where((t) => t.type.toLowerCase() == "expense")
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance => totalIncome - totalExpense;
}