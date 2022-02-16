class HistoryPayload {
  final String symbol;
  final String interval;

  HistoryPayload({
    this.symbol = 'BTCUSD',
    this.interval = 'day',
  });

  HistoryPayload copyWith({
    String? symbol,
    String? interval,
  }) {
    return HistoryPayload(
      symbol: symbol ?? this.symbol,
      interval: interval ?? this.interval,
    );
  }

  @override
  String toString() => 'HistoryPayload(symbol: $symbol, interval: $interval)';
}
