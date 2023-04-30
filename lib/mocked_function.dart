library test_toolkit;

class MockedFunction {
  final List<List> _callHistory = [];

  List<List> get callHistory => _callHistory.toList(growable: false);

  call([arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]) {
    _callHistory
        .add([arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]);
  }
}
