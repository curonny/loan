// ignore_for_file: file_names

import 'dart:convert';

Loan loanFromJson(String str) => Loan.fromJson(json.decode(str));

String loanToJson(Loan data) => json.encode(data.toJson());

class Loan {
  int id;
  String amount;
  String capacityDiscount;
  int term;
  String interestRate;
  String openingCommission;
  String totalInterestAmount;
  String initialPaymentAmount;
  String totalPaymentAmount;
  DateTime createdAt;
  DateTime updatedAt;
  int frequencyCatalogId;

  Loan({
    required this.id,
    required this.amount,
    required this.capacityDiscount,
    required this.term,
    required this.interestRate,
    required this.openingCommission,
    required this.totalInterestAmount,
    required this.initialPaymentAmount,
    required this.totalPaymentAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.frequencyCatalogId,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        amount: json["amount"],
        capacityDiscount: json["capacity_discount"],
        term: json["term"],
        interestRate: json["interest_rate"],
        openingCommission: json["opening_commission"],
        totalInterestAmount: json["total_interest_amount"],
        initialPaymentAmount: json["initial_payment_amount"],
        totalPaymentAmount: json["total_payment_amount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        frequencyCatalogId: json["frequency_catalog_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "capacity_discount": capacityDiscount,
        "term": term,
        "interest_rate": interestRate,
        "opening_commission": openingCommission,
        "total_interest_amount": totalInterestAmount,
        "initial_payment_amount": initialPaymentAmount,
        "total_payment_amount": totalPaymentAmount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "frequency_catalog_id": frequencyCatalogId,
      };
}
