import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en', ''); // Default to English

  // Getter to retrieve the current locale/language
  Locale get locale => _locale;

  // Setter to update the locale/language and notify listeners
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // Example method to get current language code (you can modify as per your implementation)
  String get currentLanguage => _locale.languageCode;
}
