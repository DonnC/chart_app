import 'package:chart_app/src/models/ticker.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final bool animate;
  // dateformat for x-axis
  final String? xFormat;
  final List<Ticker> data;

  const ChartWidget(
      {Key? key, this.animate = true, this.xFormat, this.data = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      _createSeriesData(data),
      animate: animate,
      domainAxis: const charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(format: 'd', transitionFormat: 'HH:MM'),
        ),
      ),
    );
  }

  /// Create chart data
  static List<charts.Series<Ticker, DateTime>> _createSeriesData(
      List<Ticker> data) {
    return [
      charts.Series<Ticker, DateTime>(
        id: 'Chart',
        domainFn: (Ticker row, _) => row.time!,
        measureFn: (Ticker row, _) => row.average,
        data: data,
      )
    ];
  }
}
