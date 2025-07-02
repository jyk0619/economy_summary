class StockData {
  final String symbol;
  final Map<String, dynamic> data; // 혹은 필요한 데이터 구조로 커스터마이징

  StockData({required this.symbol, required this.data});

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      symbol: json['symbol'],
      data: json['data'],
    );
  }
}
