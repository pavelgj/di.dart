library perf;

var timerFn = (fn) {
  var startTime = new DateTime.now();
  fn();
  return new DateTime.now().difference(startTime).inMilliseconds.toDouble();
};

class TimerStat {
  int count = 0;
  double total = 0.0;
  double avg = 0.0;
  double min = double.MAX_FINITE;
  double max = 0.0;
}

Map<String, TimerStat> stats = <String, TimerStat>{};

time(desc, fn) {
  var stat = stats[desc];
  if (stat == null) {
    stat = new TimerStat();
    stats[desc] = stat;
  }
  var val;
  var diff = timerFn(() {
    val = fn();
  });
  stat.count++;
  stat.total += diff;
  if (diff < stat.min) stat.min = diff;
  if (diff > stat.max) stat.max = diff;
  stat.avg = (stat.avg * (stat.count - 1) + diff) / stat.count;
  return val;
}

bool useCsvOutputForStats = true;

dumpTimerStats() {
  print('------------------------');
  if (useCsvOutputForStats) {
    print('desc;count;total;avg;min;max');
    stats.forEach((desc, stat) {
      print('$desc;${stat.count};${stat.total};${stat.avg};${stat.min};${stat.max}');
    });
  } else {
    double total = 0.0;
    stats.forEach((desc, stat) {
      print('$desc count: ${stat.count} total: ${stat.total} avg: ${stat.avg} min: ${stat.min} max: ${stat.max}');
      total += stat.total;
    });
    print('------------------------');
    print('total: $total');
  }
  print('------------------------');
}