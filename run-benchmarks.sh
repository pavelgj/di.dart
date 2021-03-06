#!/bin/sh 
set -e

BENCHMARKS="module_benchmark.dart
dynamic_injector_benchmark.dart
static_injector_benchmark.dart
instance_benchmark.dart"


# run tests in dart
for b in $BENCHMARKS
do
    dart benchmark/$b
done

# run dart2js on tests
mkdir -p out
for b in $BENCHMARKS
do
    dart2js --minify benchmark/$b   -o out/$b.js
done

# run tests in node
for b in $BENCHMARKS
do
    node out/$b.js
done
