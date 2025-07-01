
class MarketIndex {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;

  MarketIndex({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
  });

  factory MarketIndex.fromJson(Map<String, dynamic> json) {
    return MarketIndex(
      symbol: json['symbol'],
      name: json['shortName'],
      price: (json['regularMarketPrice'] as num).toDouble(),
      change: (json['regularMarketChange'] as num).toDouble(),
      changePercent: (json['regularMarketChangePercent'] as num).toDouble(),
    );
  }
}
