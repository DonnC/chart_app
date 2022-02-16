class AppUrls {
  static const String httpBaseUrl = "https://apiv2.bitcoinaverage.com/";
  static const String wsBaseUrl = "wss://apiv2.bitcoinaverage.com/";

  // endpoints
  static const String wsTicketEndpoint = "websocket/v3/get_ticket";

  static String symbolTickerDetail(String symbol) =>
      'indices/global/ticker/$symbol';

  static String globalSymbols = 'info/indices/ticker';

  /// indices/global/ticker/<symbol>  e.g BTCUSD
  static String httpHistory(String symbol, String interval) =>
      "indices/global/history/$symbol?period=$interval";
}
