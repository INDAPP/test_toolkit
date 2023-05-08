library test_toolkit;

import 'package:test_toolkit/extensions/symbol_extensions.dart';

class MockedFunction {
  final List<Invocation> _callHistory = [];
  final List _results = [];
  dynamic _defaultResult;

  List<Invocation> get callHistory => _callHistory.toList(growable: false);

  MockedFunction._();

  static create() => MockedFunction._() as dynamic;

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isMethod && invocation.memberName.name == 'call') {
      _callHistory.add(invocation);
      return _results.isNotEmpty ? _results.removeLast() : _defaultResult;
    }
    return super.noSuchMethod(invocation);
  }
}

MockedFunctionInvocation onInvoke(function) {
  if (function is! MockedFunction) {
    throw 'Function should be a MockedFunction';
  }
  return MockedFunctionInvocation(function);
}

class MockedFunctionInvocation {
  final MockedFunction function;

  MockedFunctionInvocation(this.function);

  void mockReturn(value) => function._defaultResult = value;

  void mockFuture(value) => function._defaultResult = Future.value(value);

  void mockThrows(error) => function._defaultResult = Future.error(error);

  void mockNextReturn(value) => function._results.add(value);

  void mockNextFuture(value) => function._results.add(Future.value(value));

  void mockNextThrows(error) => function._results.add(Future.error(error));
}
