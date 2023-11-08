import 'package:so_money/so_money.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('Test Indian Rupees', () {
      expect(Money(13453434522.34, 'INR').toString() == '₹ 13,45,34,34,522.34',
          isTrue);
    });
  });
}
