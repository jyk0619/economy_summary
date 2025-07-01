
class Stock {
  final String symbol;
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;
  final double change;
  final double changePercent;
  final double vwap;


  Stock({
    required this.symbol,
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.change,
    required this.changePercent,
    required this.vwap,});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      date: json['date'],
      open: json['open'].toDouble(),
      high: json['high'].toDouble(),
      low: json['low'].toDouble(),
      close: json['close'].toDouble(),
      volume: json['volume'],
      change: json['change'].toDouble(),
      changePercent: json['changePercent'].toDouble(),
      vwap: json['vwap'].toDouble(),
    );
  }
}
