import 'package:intl/intl.dart';

part 'so_currency.dart';
part 'so_rate.dart';

/// Representation of a monetary value. Money instances are immutable.
/// It support all arithmetic operations.
class Money {

  final int _value;
  // Currency
  final Currency currency;

  // Construct an instance from the for the [value] in the given [currencyCode].
  Money(num value, String currencyCode) : this.of(value, Currency.get(currencyCode));

  // Construct an instance from the for the [value] in the given [currency].
  Money.of(num value, this.currency) : _value = currency._normalize(value);

  Money._of(this._value, this.currency);

  // Value
  num get value => currency._denormalize(this);

  @override
  bool operator ==(Object other) => other is Money ? (other._value == _value && other.currency == currency) : false;

  @override
  int get hashCode => Object.hash(_value, currency);

  bool operator <(Money other) => _to(other)._value < other._value;

  bool operator <=(Money other) => _to(other)._value <= other._value;

  bool operator >(Money other) => _to(other)._value > other._value;

  bool operator >=(Money other) => _to(other)._value >= other._value;

  Money operator +(Money other) => Money._of(_value + other._to(this)._value, currency);

  Money operator -(Money other) => Money._of(_value - other._to(this)._value, currency);

  Money operator *(num quantity) => Money._of((_value * quantity).round(), currency);

  Money _to(Money another) {
    if(another.currency == currency) {
      return this;
    }
    return Money._of((_value * ExchangeRate.rate(currency, another.currency)).round(), currency);
  }

  /// Convert this instance into another currency if required by applying the respective
  /// exchange rate.
  Money to(Currency another) {
    if(another == currency) {
      return this;
    }
    return Money._of((_value * ExchangeRate.rate(currency, another)).round(), another);
  }

  @override
  String toString() {
    return format();
  }

  /// Format this monetary value for printing/displaying purposes.
  String format({NumberFormat? formatter, bool withSymbol = true, withCode = false}) => (withCode ? '${currency.code} ' : (withSymbol ? ('${currency.symbol} ') : '')) + (formatter ?? currency.formatter).format(value);
}