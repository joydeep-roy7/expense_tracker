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

}