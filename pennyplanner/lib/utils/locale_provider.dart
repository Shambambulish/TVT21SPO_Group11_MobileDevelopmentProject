import 'package:flutter/material.dart';
import 'package:pennyplanner/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({required prefsLocale}) {
    setLocale(prefsLocale);
  }
  late String prefsLocale;
  late Locale _locale;

  Locale get locale => _locale;

  void setLocale(String localeSetting) {
    late Locale newLocale;
    switch (localeSetting) {
      case "English":
        newLocale = Locale('en');
        break;
      case "Suomi":
        newLocale = Locale('fi');
        break;
    }

    if (!PPLocales.all.contains(newLocale)) return;
    _locale = newLocale;
    notifyListeners();
  }
}
