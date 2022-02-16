import 'package:chart_app/src/models/history_payload.dart';

abstract class RestServiceImpl {
  Future getGlobalSymbols() async {}

  Future getIndiceTicker(String symbol) async {}

  Future getHistory(HistoryPayload historyPayload) async {}
}
