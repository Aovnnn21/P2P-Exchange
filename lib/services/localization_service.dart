import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'P2P Exchange',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'buy': 'Buy',
      'sell': 'Sell',
      'exchange': 'Exchange',
      'wallet': 'Wallet',
      'profile': 'Profile',
      'settings': 'Settings',
      'logout': 'Logout',
      'home': 'Home',
      'orders': 'Orders',
      'chat': 'Chat',
      'search': 'Search',
      'filter': 'Filter',
      'amount': 'Amount',
      'rate': 'Rate',
      'fee': 'Fee',
      'total': 'Total',
      'confirm': 'Confirm',
      'cancel': 'Cancel',
      'send': 'Send',
      'receive': 'Receive',
      'completed': 'Completed',
      'pending': 'Pending',
      'cancelled': 'Cancelled',
    },
    'my': {
      'app_title': 'P2P ငွေလဲလှယ်ရေး',
      'login': 'ဝင်ရောက်ရန်',
      'register': 'စာရင်းသွင်းရန်',
      'email': 'အီးမေးလ်',
      'password': 'စကားဝှက်',
      'buy': 'ဝယ်မည်',
      'sell': 'ရောင်းမည်',
      'exchange': 'လဲလှယ်မည်',
      'wallet': 'ငွေအိတ်',
      'profile': 'ပရိုဖိုင်',
      'settings': 'ဆက်တင်',
      'logout': 'ထွက်ရန်',
      'home': 'ပင်မ',
      'orders': 'အော်ဒါများ',
      'chat': 'စကားဝိုင်း',
      'search': 'ရှာဖွေရန်',
      'filter': 'စစ်ထုတ်ရန်',
      'amount': 'ပမာဏ',
      'rate': 'နှုန်းထား',
      'fee': 'ကြားခံခ',
      'total': 'စုစုပေါင်း',
      'confirm': 'အတည်ပြုရန်',
      'cancel': 'ပယ်ဖျက်ရန်',
      'send': 'ပို့ရန်',
      'receive': 'လက်ခံရန်',
      'completed': 'ပြီးဆုံးပါပြီ',
      'pending': 'စောင့်ဆိုင်းနေဆဲ',
      'cancelled': 'ပယ်ဖျက်ပြီး',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get appTitle => translate('app_title');
  String get login => translate('login');
  String get register => translate('register');
  String get email => translate('email');
  String get password => translate('password');
  String get buy => translate('buy');
  String get sell => translate('sell');
  String get exchange => translate('exchange');
  String get wallet => translate('wallet');
  String get profile => translate('profile');
  String get settings => translate('settings');
  String get logout => translate('logout');
  String get home => translate('home');
  String get orders => translate('orders');
  String get chat => translate('chat');
  String get search => translate('search');
  String get filter => translate('filter');
  String get amount => translate('amount');
  String get rate => translate('rate');
  String get fee => translate('fee');
  String get total => translate('total');
  String get confirm => translate('confirm');
  String get cancel => translate('cancel');
  String get send => translate('send');
  String get receive => translate('receive');
  String get completed => translate('completed');
  String get pending => translate('pending');
  String get cancelled => translate('cancelled');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'my'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
