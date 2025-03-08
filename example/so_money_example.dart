import 'package:so_money/so_money.dart';

void main() {
  Money m1 = Money(
    13453434522.34,
    'INR',
  ); // Since INR is used for the first time, it will become the local currency.
  print('Indian rupees test: $m1'); // ₹ 13,45,34,34,522.34
  m1 -= m1;
  print('Indian rupees test (should be zero): $m1'); // ₹ 0.00
  m1 = Money(120, 'USD');
  print(m1 += m1); // $ 240.00
  Money m2 = Money(1000, '\$');
  Money m3 = Money(1000, 'USD');
  print(m1 + m2 + m3); // $ 2,240.00
  print(m1 < m2); // true
  print(m1 > m2); // false
  print(m3 * 10000000); // 10,000,000,000.00
  m1 = Money(367.5, 'AED');
  print(m1); // AED 367.50
  Currency usd = Currency.get('USD'), aed = Currency.get('AED');
  ExchangeRate(usd, aed, 3.675);
  print(m1.to(usd)); // $ 100.00
  print(m1.to(aed)); // AED 367.50
  print(m1.to(usd).to(aed)); // AED 367.50
  print(Money(5.45, 'BTC')); // ₿ 5.45000000
  ExchangeRate(aed, Currency.local, 22.2);
  print(m1.to(Currency.local));

  Money price = Money(12.54, 'USD');
  int quantity = 25;
  Money total = price * quantity;
  print('Total: $total');
}
