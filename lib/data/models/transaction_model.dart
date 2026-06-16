
class TransactionModel {

  String title;
  int amount;
  DateTime date;
  String? note;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    this.note});
}