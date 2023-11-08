part of 'so_money_base.dart';

/// A simple representation of currency. It doesn't keep/support all the international
/// details to eliminate memory overhead. Currency instances are immutable.
class Currency {

  static final Map<String, String> _symbols = {
    'USD': '\$',
    'INR': '₹',
    'EUR': '€',
    'OMR': 'OR',
    'BHD': 'BD',
  };
  static final Map<String, Currency> _cache = {
    'USD': Currency._of('USD'),
    'INR': Currency._of('INR'),
    'EUR': Currency._of('EUR'),
    'OMR': _SpecialCurrency('OMR', 3),
    'BHD': _SpecialCurrency('BHD', 3),
  };
  static final Map<String, NumberFormat> _formatters = {
    'INR': NumberFormat('##,##,##0.00'),
  };
  static final NumberFormat _formatter0 = NumberFormat('###,##0');
  static final NumberFormat _formatter2 = NumberFormat('###,##0.00');
  static final NumberFormat _formatter3 = NumberFormat('###,##0.000');

  /// Currency code
  final String code;

  Currency._of(this.code);

  /// Number of decimals of this currency.
  int get decimals => 2;

  /// Symbol used by this currency.
  String get symbol {
    return _symbols[code] ?? code;
  }
  
  /// Number formatter to be used for formatting this currency.
  NumberFormat get formatter {
    NumberFormat? f = _formatters[code];
    if(f != null) {
      return f;
    }
    int d = decimals;
    switch(d) {
      case 2: return _formatter2;
      case 3: return _formatter3;
      case 0: return _formatter0;
    }
    String s = '###,##0.';
    while(d-- > 0) {
      s += '0';
    }
    return NumberFormat(s);
  }

  /// Get currency for the given currency [code] or [symbol].
  static Currency get(String code) {
    Currency? currency;
    code = code.trim().toUpperCase();
    currency = _cache[code];
    if(currency != null) {
      return currency;
    }
    String c = _symbols.keys.firstWhere((k) => _symbols[k] == code, orElse: () => '');
    if(c.isNotEmpty) {
      return _cache[c]!;
    }
    currency = Currency._of(code);
    _cache[code] = currency;
    return currency;
  }

  /// Set the [symbol] of a [currency]. This is normally not used unless you want
  /// to change the value return by the symbol property.
  static void setSymbol(Currency currency, String symbol) {
    if(symbol.isNotEmpty) {
      _symbols[currency.code] = symbol;
    }
  }
  
  /// Set the formatter for a [currency]. This is normally not used unless you
  /// want to change the return value of the formatter property.
  /// If you set it to null, the default formatter will be used hereafter.
  static void setFormatter(Currency currency, NumberFormat? formatter) {
    if(formatter == null) {
      _formatters.remove(currency.code);
    } else {
      _formatters[currency.code] = formatter;
    }
  }
  
  int _normalize(num value) {
    int d = decimals;
    switch(d) {
      case 2: return (value * 100).round();
      case 3: return (value * 1000).round();
      case 0: return value.round();
      case 1: return (value * 10).round();
    }
    while(d-- > 0) {
      value *= 10;
    }
    return value.round();
  }
  
  num _denormalize(Money money) {
    num value = money._value;
    int d = decimals;
    switch(d) {
      case 2: return value / 100;
      case 3: return value / 1000;
      case 0: return value;
      case 1: return value / 10;
    }
    while(d-- > 0) {
      value /= 10;
    }
    return value;
  }

  @override
  bool operator ==(Object other) {
    return other is Currency ? other.code == code : false;
  }

  @override
  int get hashCode => code.hashCode;
}

class _SpecialCurrency extends Currency {

  @override
  final int decimals;

  _SpecialCurrency(super.code, this.decimals) : super._of();
}