import 'package:flutter/material.dart';
import '../card-detection/card_utils.dart';
import 'dart:core';

class CardModel with ChangeNotifier {
  String _cardNumber = "#### #### #### ####";
  String _cardHolder = "FULL NAME";
  String _expiryMonth = 'MM';
  String _expiryYear = 'YY';
  String _activeField = ''; 
  String _cvv = ''; 
  String _cardBrand = "visa"; // Standardlogotyp

  // Dynamisk lista av månader - Uppdaterade denna också
  final List<String> months = List<String>.generate(13, (index) {
    return index == 0 ? 'MM' : index.toString().padLeft(2, '0');
  });

  // Dynamisk lista av år baserat på aktuellt år - Uppdaterad
  List<String> get years {
  final currentYear = DateTime.now().year;
  return ['YY', ...List.generate(10, (index) => (currentYear + index).toString())];
  }

  // Getters
  String get cardNumber => _cardNumber;
  String get cardHolder => _cardHolder;
  String get expiryMonth => _expiryMonth;
  String get expiryYear => _expiryYear;
  String get activeField => _activeField;
  String get cvv => _cvv; 
  String get cardBrand => _cardBrand;

  List<String> get availableMonths => months;
  List<String> get availableYears => years;

  // Sätt aktivt fält
  void setActiveField(String fieldName) {
    _activeField = fieldName;
    notifyListeners();
  }

  // Kortnummer och kortlogotyp - Uppdaterad
  void updateCardNumber(String value) {
  final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  final isAmex = CardUtils.getCardBrand(cleanedValue) == 'amex';
  final maxLength = isAmex ? 15 : 16; // Amex 15 siffror

  final paddedValue = cleanedValue.padRight(maxLength, '#');
  _cardNumber = _formatCardNumber(paddedValue, isAmex);
  _cardBrand = CardUtils.getCardBrand(cleanedValue) ?? "visa";
  notifyListeners();
  }

  // Formatera kortnummer - Uppdaterad
  String _formatCardNumber(String value, bool isAmex) {
    if (isAmex) {
      return value
          .replaceAllMapped(RegExp(r'^(\d{1,4})(\d{1,6})?(\d{1,5})?'), (match) {
        return [
          match.group(1),
          match.group(2),
          match.group(3),
        ].where((e) => e != null).join(' ');
      }).trim();
    } else {
      return value.replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ").trim();
    }
  }


  // Uppdatera kortinnehavarens namn
  void updateCardHolder(String value) {
    _cardHolder = value.toUpperCase().substring(0, value.length > 24 ? 24 : value.length);
    notifyListeners();
  }

  void updateExpiryDate(String month, String year) {
    _expiryMonth = month;
    _expiryYear = year;
    notifyListeners();
  }

  // Ny metod för att hämta de sista två siffrorna av året
  String get expiryYearShort {
    if (_expiryYear == 'YY') return 'YY';
    return _expiryYear.substring(2); // Tar bara de sista två siffrorna
  }

  // Uppdatera CVV
  void updateCVV(String value) {
    _cvv = value.substring(0, value.length > 3 ? 3 : value.length);
    notifyListeners();
  }
}
