import 'package:expense_tracker/data/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TransactionController extends GetxController {
  late Box<TransactionModel> box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box<TransactionModel>('transactions');
  }

  /// ADD
  void addTransaction(TransactionModel transaction) {
    box.add(transaction);
    update();

  }

  /// DELETE
  void removeTransaction(dynamic key) {
    box.delete(key);
    update();
  }

  /// UPDATE
  void updateTransaction(
      dynamic key,
      TransactionModel transaction,
      ) {
    box.put(key, transaction);
    update();
  }

  /// CALCULATIONS
  double get totalIncome {
    return box.values
        .where((t) => t.type.toLowerCase() == "income")
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return box.values
        .where((t) => t.type.toLowerCase() == "expense")
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance => totalIncome - totalExpense;
}