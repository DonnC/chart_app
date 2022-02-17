import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:chart_app/src/constants/app_keys.dart';
import 'package:chart_app/src/constants/app_url.dart';
import 'package:chart_app/src/models/global_symbols.dart';
import 'package:chart_app/src/models/history_payload.dart';
import 'package:chart_app/src/models/symbol_ticker_detail.dart';
import 'package:chart_app/src/models/ticker.dart';
import 'package:chart_app/src/services/rest_service_impl.dart';

class RestServiceDef implements RestServiceImpl {
  late Dio _dio;

  RestServiceDef() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.httpBaseUrl,
        connectTimeout: 60000,
        receiveTimeout: 50000,
        headers: {
          'x-ba-key': headerKey,
        },
      ),
    );
  }

  @override
  Future getGlobalSymbols() async {
    try {
      var result = await _dio.get(AppUrls.globalSymbols);

      if (result.statusCode == 200) {
        return GlobalSymbols.fromRawJson(result.toString());
      }
    }

    //
    catch (e) {
      log('getGlobalSymbols Error: ', error: e);
    }
  }

  @override
  Future<SymbolTicker?> getIndiceTicker(String symbol) async {
    try {
      var result = await _dio.get(AppUrls.symbolTickerDetail(symbol));

      if (result.statusCode == 200) {
        return SymbolTicker.fromRawJson(result.toString());
      }
    }

    //
    catch (e) {
      log('getIndiceTicker Error: ', error: e);
    }
  }

  @override
  Future<List<Ticker>?> getHistory(HistoryPayload historyPayload) async {
    try {
      var result = await _dio.get(
          AppUrls.httpHistory(historyPayload.symbol, historyPayload.interval));

      if (result.statusCode == 200) {
        final data = result.data as List;

        final r = data.map((e) => Ticker.fromJson(e)).toList();

        return r;
      }
    }

    //
    catch (e) {
      log('getHistory Error: $e', error: e);
    }
  }
}
