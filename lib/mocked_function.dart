library test_toolkit;

import 'package:test_toolkit/extensions/symbol_extensions.dart';

class MockedFunction {
  final List<Invocation> _callHistory = [];
  final List _results = [];
  dynamic _defaultResult;

  List<Invocation> get callHistory => _callHistory.toList(growable: false);

  get callable => this as dynamic;

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isMethod && invocation.memberName.name == 'call') {
      _callHistory.add(invocation);
      return _results.isNotEmpty ? _results.removeLast() : _defaultResult;
    }
    return super.noSuchMethod(invocation);
  }

  void mockReturn(value) => _defaultResult = value;

  void mockFuture(value) => _defaultResult = Future.value(value);

  void mockThrows(error) => _defaultResult = Future.error(error);

  void mockNextReturn(value) => _results.add(value);

  void mockNextFuture(value) => _results.add(Future.value(value));

  void mockNextThrows(error) => _results.add(Future.error(error));
}
