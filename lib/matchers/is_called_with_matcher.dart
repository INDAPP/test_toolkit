import 'package:collection/collection.dart';
import 'package:test/test.dart';

import '../mocked_function.dart';
import '../mocked_function_mismatch.dart';

Matcher isCalledWith(List args, {int? nTh}) =>
    _MockedFunctionCallWith(args, nTh: nTh);

Function _listEquals = const ListEquality().equals;

class _MockedFunctionCallWith extends Matcher {
  final List args;
  final int? nTh;

  _MockedFunctionCallWith(this.args, {this.nTh});

  @override
  Description describe(Description description) {
    final args = this.args;
    description.add(
      '<Expect function to have been called with'
      '${args.isEmpty ? ' no arguments' : args.join(', ')}>',
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
    final callHistory = item.callHistory;
    final args = this.args;
    final nTh = this.nTh;
    if (nTh != null) {
      if (nTh > callHistory.length) {
        matchState[MockedFunctionMismatch.lessCallsThanExpected] =
            'Expected arguments in ${nTh}th call but only '
            '${callHistory.length} calls made';
        return false;
      }
      final callArgs = callHistory[nTh - 1].positionalArguments;
      if (!_listEquals(args, callArgs)) {
        matchState[MockedFunctionMismatch.argumentsMismatch] =
            'Expected arguments [${args.join(', ')}] differ from those passed ['
            '${callArgs.join(', ')}]';
        return false;
      }
    } else {
      if (callHistory.isEmpty) {
        matchState[MockedFunctionMismatch.notCalled] = 'Function not called';
        return false;
      }
      if (!callHistory.any(
        (callArgs) => _listEquals(
          args,
          callArgs.positionalArguments,
        ),
      )) {
        matchState[MockedFunctionMismatch.noMatchingArguments] =
            'No calls with matching arguments';
        return false;
      }
    }

    return true;
  }
}
