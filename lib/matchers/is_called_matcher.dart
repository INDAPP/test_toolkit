import 'package:test/test.dart';

import '../mocked_function.dart';
import '../mocked_function_mismatch.dart';

Matcher isCalled({int? times}) => _MockedFunctionCallMatcher(times: times);

class _MockedFunctionCallMatcher extends Matcher {
  final int? times;

  _MockedFunctionCallMatcher({this.times});

  @override
  Description describe(Description description) {
    final times = this.times;
    description.add(
      '<Expect function to have been called'
      '${times != null ? ' $times times>' : '>'}',
    );
    return description;
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    matchState.values.whereType<String>().forEach(mismatchDescription.add);
    return mismatchDescription;
  }

  @override
  bool matches(item, Map matchState) {
    if (item is! MockedFunction) {
      matchState[MockedFunctionMismatch.notAMockedFunction] =
          'Not a mocked function';
      return false;
    }
    final times = this.times;
    final callHistory = item.callHistory;
    if (times != null && callHistory.length != times) {
      matchState[MockedFunctionMismatch.wrongNumberOfCalls] =
          'Wrong number of calls: ${callHistory.length} received, '
          '$times expected';
      return false;
    }
    if (callHistory.isEmpty && times != 0) {
      matchState[MockedFunctionMismatch.notCalled] = 'Function not called';
      return false;
    }

    return true;
  }
}
