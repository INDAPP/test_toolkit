library test_toolkit;

import 'package:test_toolkit/extensions/symbol_extensions.dart';

class MockedFunction {
  final List<Invocation> _callHistory = [];

  List<Invocation> get callHistory => _callHistory.toList(growable: false);

  MockedFunction._();

  static create() => MockedFunction._() as dynamic;

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isMethod && invocation.memberName.name == 'call') {
      _callHistory.add(invocation);
      return;
    }
    return super.noSuchMethod(invocation);
  }
}
