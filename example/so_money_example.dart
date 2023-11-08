import 'package:so_money/so_money.dart';

void main() {
  Money m1 = Money(13453434522.34, 'INR');
  print('Indian rupees test: $m1');
  m1 -= m1;
  print('Indian rupees test (should be zero): $m1');
  m1 = Money(120, 'USD');
  print('$m1 += ${m1 += m1}');
  Money m2 = Money(1000, '\$');
  Money m3 = Money(1000, 'USD');
  print('$m1 + $m2 + $m3 = ${m1 + m2 + m3}');
  print('$m1 < $m2 = ${m1 < m2}');
  print('$m1 > $m2 = ${m1 > m2}');
  print(m3 * 10000000);
  m1 = Money(367.5, 'AED');
  print(m1);
  ExchangeRate(Currency.get('USD'), Currency.get('AED'), 3.675);
  print(m1.to(Currency.get('USD')));
  print(m1.to(Currency.get('AED')));
}
