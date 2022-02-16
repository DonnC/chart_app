import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:chart_app/src/models/global_symbols.dart';
import 'package:chart_app/src/models/history_payload.dart';
import 'package:chart_app/src/models/symbol_ticker_detail.dart';
import 'package:chart_app/src/models/ticker.dart';
import 'package:chart_app/src/models/timeframe.dart';
import 'package:chart_app/src/services/rest_service_default.dart';
import 'package:chart_app/src/widgets/chart_widget.dart';
import 'package:chart_app/src/widgets/prices_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = RestServiceDef();

  HistoryPayload _payload = HistoryPayload();

  List<Ticker> data = [];

  double? dailyChange = 0.0;

  bool _loading = false;

  int _intervalSelected = 1;

  Future<void> fetchHistory() async {
    setState(() {
      _loading = true;
    });

    log(_payload.toString());

    final res = await api.getHistory(_payload);

    if (res == null) {
      log('failed to load data');
    }

    setState(() {
      _loading = false;
      data = res ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart App"),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder(
              future: api.getGlobalSymbols(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final symbolsList = snapshot.data as GlobalSymbols;

                  final symbols = symbolsList.global?.symbols ?? [];

                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  underline: null,
                                  value: _payload.symbol,
                                  style: Theme.of(context).textTheme.headline3,
                                  items: symbols
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) async {
                                    var _copy = _payload.copyWith(symbol: val);
                                    setState(() {
                                      _payload = _copy;
                                    });

                                    await fetchHistory();
                                  },
                                ),
                              ),
                              //  const Spacer(),
                              const VerticalDivider(thickness: 2),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  Text(
                                    '24H Change',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      dailyChange! < 0
                                          ? const Icon(Icons.arrow_downward,
                                              color: Colors.red)
                                          : const Icon(Icons.arrow_upward,
                                              color: Colors.green),
                                      Text(
                                          '${dailyChange?.toStringAsFixed(2)}%'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      FutureBuilder(
                          future: api.getIndiceTicker(_payload.symbol),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final _data = snapshot.data as SymbolTicker;
                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((_) {
                                setState(() {
                                  dailyChange =
                                      _data.changes?.percent?.day ?? 0.0;
                                });
                              });

                              return PriceCard(data: _data);
                            }

                            // loader
                            else {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                          }),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Spacer(),
                          Row(
                            children: TimeFrame.timeframes
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () async {
                                      final _ccopy = _payload.copyWith(
                                          interval: e.timeframe);

                                      setState(() {
                                        _intervalSelected = e.index;
                                        _payload = _ccopy;
                                      });

                                      await fetchHistory();
                                    },
                                    child: Card(
                                      color: _intervalSelected == e.index
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e.timeframe),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChartWidget(data: data),
                        ),
                      )),
                    ],
                  );
                }

                // load symbols
                else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }),
    );
  }
}
