// ignore_for_file: file_names

import 'dart:convert';

Frecuency frecuencyFromJson(String str) => Frecuency.fromJson(json.decode(str));

String frecuencyToJson(Frecuency data) => json.encode(data.toJson());

class Frecuency {
  int id;
  String name;
  int paymentsPerYear;
  DateTime createdAt;
  DateTime updatedAt;

  Frecuency({
    required this.id,
    required this.name,
    required this.paymentsPerYear,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Frecuency.fromJson(Map<String, dynamic> json) => Frecuency(
        id: json["id"],
        name: json["name"],
        paymentsPerYear: json["payments_per_year"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "payments_per_year": paymentsPerYear,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
