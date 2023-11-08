part of 'so_money_base.dart';

/// Representation of exchange rate between currencies.
class ExchangeRate {
  static final Map<String, ExchangeRate> _cache = {};
  final Currency from, to;
  final num multiplier;

  /// Define an exchange rate to convert one currency to another by providing
  /// a multiplication factor. Typically, you don't need to defne a reverse rate
  /// too because the [rate] method automatically takes care of inverting
  /// the value for the reverse conversion.
  ExchangeRate(this.from, this.to, this.multiplier) {
    _cache[from.code + to.code] = this;
  }

  /// Get the multiplication factor to be used to convert the monetary value
  /// of one currency to another.
  static num rate(Currency from, Currency to) {
    ExchangeRate? r = _cache[from.code + to.code];
    if (r != null) {
      return r.multiplier;
    }
    r = _cache[to.code + from.code];
    if (r != null) {
      return 1 / r.multiplier;
    }
    throw 'Exchange rate not found for ${from.code} to ${to.code}';
  }
}
