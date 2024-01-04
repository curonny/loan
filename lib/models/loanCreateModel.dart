// To parse this JSON data, do
//
//     final loanDetails = loanDetailsFromJson(jsonString);

import 'dart:convert';

LoanDetails loanDetailsFromJson(String str) =>
    LoanDetails.fromJson(json.decode(str));

String loanDetailsToJson(LoanDetails data) => json.encode(data.toJson());

class LoanDetails {
  int loanId;
  Summary summary;
  List<AmortizationPlan> amortizationPlan;

  LoanDetails({
    required this.loanId,
    required this.summary,
    required this.amortizationPlan,
  });

  factory LoanDetails.fromJson(Map<String, dynamic> json) => LoanDetails(
        loanId: json["loan_id"],
        summary: Summary.fromJson(json["summary"]),
        amortizationPlan: List<AmortizationPlan>.from(
            json["amortization_plan"].map((x) => AmortizationPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loan_id": loanId,
        "summary": summary.toJson(),
        "amortization_plan":
            List<dynamic>.from(amortizationPlan.map((x) => x.toJson())),
      };
}

class AmortizationPlan {
  int id;
  int paymentNumber;
  String principalAmount;
  String interestAmount;
  String totalPayment;
  String remainingBalance;
  int loanId;

  AmortizationPlan({
    required this.id,
    required this.paymentNumber,
    required this.principalAmount,
    required this.interestAmount,
    required this.totalPayment,
    required this.remainingBalance,
    required this.loanId,
  });

  factory AmortizationPlan.fromJson(Map<String, dynamic> json) =>
      AmortizationPlan(
        id: json["id"],
        paymentNumber: json["payment_number"],
        principalAmount: json["principal_amount"],
        interestAmount: json["interest_amount"],
        totalPayment: json["total_payment"],
        remainingBalance: json["remaining_balance"],
        loanId: json["loan_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_number": paymentNumber,
        "principal_amount": principalAmount,
        "interest_amount": interestAmount,
        "total_payment": totalPayment,
        "remaining_balance": remainingBalance,
        "loan_id": loanId,
      };
}

class Summary {
  String amount;
  String quota;
  int frequencyId;
  int term;
  String interestRate;
  String openingCommission;
  String totalInterestAmount;
  String initialPaymentAmount;
  String totalPaymentAmount;

  Summary({
    required this.amount,
    required this.quota,
    required this.frequencyId,
    required this.term,
    required this.interestRate,
    required this.openingCommission,
    required this.totalInterestAmount,
    required this.initialPaymentAmount,
    required this.totalPaymentAmount,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        amount: json["amount"],
        quota: json["quota"],
        frequencyId: json["frequency_id"],
        term: json["term"],
        interestRate: json["interest_rate"],
        openingCommission: json["opening_commission"],
        totalInterestAmount: json["total_interest_amount"],
        initialPaymentAmount: json["initial_payment_amount"],
        totalPaymentAmount: json["total_payment_amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "quota": quota,
        "frequency_id": frequencyId,
        "term": term,
        "interest_rate": interestRate,
        "opening_commission": openingCommission,
        "total_interest_amount": totalInterestAmount,
        "initial_payment_amount": initialPaymentAmount,
        "total_payment_amount": totalPaymentAmount,
      };
}
