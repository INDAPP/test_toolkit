import 'package:flutter_test/flutter_test.dart';
import 'package:test_toolkit/matchers/is_called_matcher.dart';
import 'package:test_toolkit/mocked_function.dart';

main() {
  group('isCalled matcher', () {
    test('should match a mocked function call', () {
      final function = MockedFunction();
      function();
      expect(function, isCalled());
    });

    test('should match mocked function multiple calls', () {
      final function = MockedFunction();
      for (var i = 0; i < 3; i++) {
        function();
      }
      expect(function, isCalled(times: 3));
    });

    test('should match zero call when function is not called', () {
      final function = MockedFunction();
      expect(function, isCalled(times: 0));
    });
  });
}
