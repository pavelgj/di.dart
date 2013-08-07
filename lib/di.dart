library di;

import 'dart:collection';

import 'mirrors.dart';

part 'errors.dart';
part 'providers.dart';
part 'module.dart';
part 'injector.dart';

Map<String, double> totalCount = <String, double>{};

Function timeKeeper = (fn) {
  var startTime = new DateTime.now();
  fn();
  return new DateTime.now().difference(startTime).inMilliseconds.toDouble();
};

time(desc, fn) {
  var total = totalCount[desc];
  if (total == null) total = 0;
  var res;
  var diff = timeKeeper(() {
    res = fn();
  });
  total += diff;
  totalCount[desc] = total;
  return res;
}

dumpStats() {
  print('---------------------------');
  totalCount.forEach((desc, total) {
    print('$desc $total');
  });
  print('---------------------------');
}