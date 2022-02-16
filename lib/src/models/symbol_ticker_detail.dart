import 'dart:convert';

class SymbolTicker {
  SymbolTicker({
    this.ask,
    this.bid,
    this.last,
    this.high,
    this.low,
    this.volume,
    this.open,
    this.changes,
    this.volumePercent,
    this.timestamp,
    this.displayTimestamp,
    this.displaySymbol,
  });

  final double? ask;
  final double? bid;
  final double? last;
  final double? high;
  final double? low;
  final double? volume;
  final Open? open;
  final Changes? changes;
  final double? volumePercent;
  final int? timestamp;
  final DateTime? displayTimestamp;
  final String? displaySymbol;

  factory SymbolTicker.fromRawJson(String str) =>
      SymbolTicker.fromJson(json.decode(str));

  factory SymbolTicker.fromJson(Map<String, dynamic> json) => SymbolTicker(
        ask: json["ask"].toDouble(),
        bid: json["bid"].toDouble(),
        last: json["last"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        volume: json["volume"].toDouble(),
        open: Open.fromJson(json["open"]),
        changes: Changes.fromJson(json["changes"]),
        timestamp: json["timestamp"],
        displayTimestamp: DateTime.parse(json["display_timestamp"]),
        displaySymbol: json["display_symbol"],
      );
}

class Changes {
  Changes({
    this.price,
    this.percent,
  });

  final Open? price;
  final Open? percent;

  factory Changes.fromRawJson(String str) => Changes.fromJson(json.decode(str));

  factory Changes.fromJson(Map<String, dynamic> json) => Changes(
        price: Open.fromJson(json["price"]),
        percent: Open.fromJson(json["percent"]),
      );
}

class Open {
  Open({
    this.hour,
    this.day,
    this.week,
    this.month,
    this.month3,
    this.month6,
    this.year,
  });

  final double? hour;
  final double? day;
  final double? week;
  final double? month;
  final double? month3;
  final double? month6;
  final double? year;

  factory Open.fromRawJson(String str) => Open.fromJson(json.decode(str));

  factory Open.fromJson(Map<String, dynamic> json) => Open(
        hour: double.tryParse(json["hour"].toString()) ?? 0.0,
        day: json["day"].toDouble(),
        week: json["week"].toDouble(),
        month: json["month"].toDouble(),
        month3: json["month_3"].toDouble(),
        month6: json["month_6"].toDouble(),
        year: json["year"].toDouble(),
      );
}
