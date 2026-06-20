import 'package:expense_tracker/data/models/transaction_model.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  List<TransactionModel> transactionData = [];

  void addTransaction (TransactionModel transaction) {
    transactionData.add(transaction);
    update();
  }

  void removeTransaction (int index) {
    transactionData.removeAt(index);
    update();
  }

  void updateTransaction (int index, TransactionModel transaction) {
    transactionData[index] = transaction;
    update();
  }



  // calculated data

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

  double get totalBalance {
    return totalIncome - totalExpense;
  }

}