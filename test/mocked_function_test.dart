import 'package:flutter_test/flutter_test.dart';
import 'package:test_toolkit/mocked_function.dart';

main() {
  group('MockedFunction', () {
    final returnValue = Symbol('test');
    final returnError = Error();

    test('should mock default return value', () {
      final function = MockedFunction();
      function.mockReturn(returnValue);
      expect(function.callable(), returnValue);
      expect(function.callable(), returnValue);
    });

    test('should mock default future result value', () async {
      final function = MockedFunction();
      function.mockFuture(returnValue);
      expect(await function.callable(), returnValue);
      expect(await function.callable(), returnValue);
    });

    test('should mock default future result error', () {
      final function = MockedFunction();
      function.mockThrows(returnError);
      expect(function.callable(), throwsA(returnError));
    });

    test('should mock return value once', () {
      final function = MockedFunction();
      function.mockNextReturn(returnValue);
      expect(function.callable(), returnValue);
      expect(function.callable(), isNull);
    });

    test('should mock future result value once', () async {
      final function = MockedFunction();
      function.mockNextFuture(returnValue);
      expect(await function.callable(), returnValue);
      expect(await function.callable(), isNull);
    });

    test('should mock future result error once', () async {
      final function = MockedFunction();
      function.mockNextThrows(returnError);
      expect(function.callable(), throwsA(returnError));
      expect(await function.callable(), isNull);
    });

    test('should mock return value multiple times', () {
      final function = MockedFunction();
      final times = 3;
      for (var i = 0; i < times; i++) {
        function.mockNextReturn(returnValue);
      }
      for (var i = 0; i < times; i++) {
        expect(function.callable(), returnValue);
      }
      expect(function.callable(), isNull);
    });
  });
}
