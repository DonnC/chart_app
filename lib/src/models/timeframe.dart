class TimeFrame {
  final String timeframe;
  final String dateformat;
  final int index;

  TimeFrame({
    this.timeframe = 'minute',
    this.dateformat = 'MM/dd/yyyy HH:MM',
    this.index = 0,
  });

  static List<TimeFrame> get timeframes => [
        TimeFrame(),
        TimeFrame(timeframe: 'day', index: 1),
        TimeFrame(timeframe: 'month', index: 2),
      ];
}
