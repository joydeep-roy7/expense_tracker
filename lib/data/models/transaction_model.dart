// import 'package:hive/hive.dart';
// part 'transaction_model.g.dart';
//
// @HiveType(typeId: 0)
// class TransactionModel extends HiveObject {
//
//   @HiveField(0)
//   late String title;
//
//   @HiveField(1)
//   late double amount;
//
//   @HiveField(2)
//   late String type; // 'income' or 'expense'
//
//   @HiveField(3)
//   late DateTime date;
//
//   @HiveField(4)
//   String? note;
//
//   TransactionModel({
//     required this.title,
//     required this.amount,
//     required this.type,
//     required this.date,
//     this.note,
//   });
// }

class TransactionModel {
  String title;
  double amount;
  String type;
  DateTime date;
  String? note;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    this.note,
  });
}
