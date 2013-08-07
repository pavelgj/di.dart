import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:di/di.dart';
import 'dart:mirrors';
import 'dart:html';

class InjectorBenchmark extends BenchmarkBase {
  InjectorBenchmark() : super("Injector");

  static void main() {
    new InjectorBenchmark().report();
  }

  void run() {
    var injector = new Injector();
    registerTypeProvider(A, (getInstanceBySymbol, error) {
      return new A(getInstanceBySymbol(getTypeSymbol(B)), getInstanceBySymbol(getTypeSymbol(C)));
    });
    registerTypeProvider(B, (getInstanceBySymbol, error) {
      return new B(getInstanceBySymbol(getTypeSymbol(D)), getInstanceBySymbol(getTypeSymbol(E)));
    });
    registerTypeProvider(C, (getInstanceBySymbol, error) {
      return new C();
    });
    registerTypeProvider(D, (getInstanceBySymbol, error) {
      return new D();
    });
    registerTypeProvider(E, (getInstanceBySymbol, error) {
      return new E();
    });
    injector.get(A);
  }

  void setup() {
  }

  void teardown() {
    dumpStats();
  }
}

Symbol getTypeSymbol(Type type) => reflectClass(type).qualifiedName;


class A {
  A(B b, C c);
}

class B {
  B(D b, E c);
}

class C {
  
}

class D {
  
}

class E {
  
}

main() {
  timeKeeper = (fn) {
    var startTime = window.performance.now();
    fn();
    return window.performance.now() - startTime;
  };
  InjectorBenchmark.main();
}