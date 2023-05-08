import 'package:flutter_test/flutter_test.dart';
import 'package:test_toolkit/matchers/is_called_with_matcher.dart';
import 'package:test_toolkit/mocked_function.dart';

main() {
  group('isCalledWith matcher', () {
    test('should match a mocked function call with no arguments', () {
      final function = MockedFunction.create();
      function();
      expect(function, isCalledWith([]));
    });

    test('should match a mocked function call with arguments', () {
      final function = MockedFunction.create();
      function('arg', 1);
      expect(function, isCalledWith(['arg', 1]));
    });

    group('when there are multiple calls', () {
      final function = MockedFunction.create();
      function();
      function(true, 1);
      function('arg');

      test('should match a mocked function call with arguments', () {
        expect(function, isCalledWith([true, 1]));
      });

      test('should match a mocked function call with no arguments', () {
        expect(function, isCalledWith([]));
      });

      test('should match a mocked function nTh call with arguments', () {
        expect(function, isCalledWith(['arg'], nTh: 3));
      });
    });
  });
}
