import 'package:expense_tracker/data/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TransactionController extends GetxController {
  late final Box<TransactionModel> box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box<TransactionModel>('transactions');
  }

  /// ADD
  Future<void> addTransaction(TransactionModel transaction) async {
    await box.add(transaction);
    update();
  }

  /// DELETE
  Future<void> removeTransaction(dynamic key) async {
    await box.delete(key);
    update();
  }

  /// UPDATE
  Future<void> updateTransaction(
      dynamic key,
      TransactionModel transaction,
      ) async {
    await box.put(key, transaction);
    update();
  }

  /// TOTAL INCOME
  double get totalIncome {
    return box.values
        .where((e) => e.type.toLowerCase() == "income")
        .fold<double>(0, (sum, e) => sum + e.amount);
  }

  /// TOTAL EXPENSE
  double get totalExpense {
    return box.values
        .where((e) => e.type.toLowerCase() == "expense")
        .fold<double>(0, (sum, e) => sum + e.amount);
  }

  /// BALANCE
  double get totalBalance => totalIncome - totalExpense;
}