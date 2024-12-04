import 'package:flutter/material.dart';
import '../card-detection/card_utils.dart';

class CardModel with ChangeNotifier {
  String _cardNumber = "#### #### #### ####";
  String _cardHolder = "FULL NAME";
  String _expiryMonth = 'MM';
  String _expiryYear = 'YY';
  String _activeField = ''; 
  String _cvv = ''; 
  String _cardBrand = "visa"; // Standardlogotyp

  final List<String> months = [
    'MM', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'
  ];
  final List<String> years = [
    'YY', '2024', '2025', '2026', '2027', '2028', '2029', '2030'
  ];

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

  // Uppdatera kortnummer och kortlogotyp
  void updateCardNumber(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    final paddedValue = cleanedValue.padRight(16, '#');
    _cardNumber = _formatCardNumber(paddedValue);
    _cardBrand = CardUtils.getCardBrand(cleanedValue) ?? "visa";
    notifyListeners();
  }

  // Formatera kortnummer
  String _formatCardNumber(String value) {
    return value.replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ").trim();
  }

  // Uppdatera kortinnehavarens namn
  void updateCardHolder(String value) {
    _cardHolder = value.toUpperCase().substring(0, value.length > 24 ? 24 : value.length);
    notifyListeners();
  }

  // Uppdatera giltighetstid
  void updateExpiryDate(String month, String year) {
    _expiryMonth = month;
    _expiryYear = year;
    notifyListeners();
  }

  // Uppdatera CVV
  void updateCVV(String value) {
    _cvv = value.substring(0, value.length > 3 ? 3 : value.length);
    notifyListeners();
  }
}
