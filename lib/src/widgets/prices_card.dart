import 'package:chart_app/src/models/symbol_ticker_detail.dart';
import 'package:flutter/material.dart';

import 'home_card.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key, required this.data}) : super(key: key);

  final SymbolTicker data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          HomeCard(
            value: '${data.ask?.toStringAsFixed(2)}',
            title: 'ask',
          ),
          const SizedBox(width: 5),
          HomeCard(
            value: '${data.open?.day?.toStringAsFixed(2)}',
            title: 'open 24H',
          ),
          const SizedBox(width: 5),
          HomeCard(
            value: '${data.volume?.toStringAsFixed(2)}',
            title: 'volume',
          ),
          const SizedBox(width: 5),
          HomeCard(
            value:
                '${data.low?.toStringAsFixed(2)} / ${data.high?.toStringAsFixed(2)}',
            title: 'low/high',
          ),
        ],
      ),
    );
  }
}
