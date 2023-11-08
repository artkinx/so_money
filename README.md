This package provides classes required to manipulate monetary values.
## Features
The main class `Money` can be used very intuitively to carry out all sort of arithmetic operations and comparisons
on monetary values.

The package also contains a `Currency` class to represent currencies (including metals and cryptos) and an `ExchangeRate` class 
to represent cross-currency exchange rates.

## Getting started

You may import this library to your dart application with the following commands (in your project folder):

```shell
dart pub add so_money
dart pub get
```

In flutter applications, you could use the following commands:
```shell
flutter pub add so_money
flutter pub get
```

## Usage

```dart
void main() {
  Money m1 = Money(13453434522.34, 'INR');
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
  print(Money(5.45, 'BTC')); // ₿ 5.45000000
}
```

## Additional information

Please report issues related to this package at the [GitHub repository](https://github.com/syampillai/so_money/issues).