
class Currency {
  final String unit;
  final String rate;
  final String name;

  Currency({required this.unit, required this.rate, required this.name});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      unit: json['cur_unit'],
      rate: json['deal_bas_r'],
      name: json['cur_nm'],
    );
  }
}
