
class Currency {
  final String unit;
  final String rate;

  Currency({required this.unit, required this.rate});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      unit: json['cur_unit'],
      rate: json['deal_bas_r'],
    );
  }
}
