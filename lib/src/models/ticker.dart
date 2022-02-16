import 'dart:convert';

class Ticker {
  Ticker({
    this.average,
    this.time,
    this.high,
    this.low,
    this.open,
    this.volume,
  });

  final double? average;
  final DateTime? time;
  final double? high;
  final double? low;
  final double? open;
  final double? volume;

  factory Ticker.fromRawJson(String str) => Ticker.fromJson(json.decode(str));

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
        average: double.tryParse(json["average"].toString()) ?? 0.0,
        time: DateTime.parse(json["time"]),
        high: json["high"]?.toDouble(),
        low: json["low"]?.toDouble(),
        open: json["open"]?.toDouble(),
        volume: json["volume"]?.toDouble(),
      );
}
