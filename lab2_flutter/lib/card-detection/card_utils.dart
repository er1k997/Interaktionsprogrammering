class CardUtils {
  static String? getCardBrand(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return 'visa';
    } else if (cardNumber.startsWith('5')) {
      return 'mastercard';
    } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      return 'amex';
    } else if (cardNumber.startsWith('62')) {
      return 'unionpay';
    } else if (cardNumber.startsWith('6')) {
      return 'discover';
    } else if (RegExp(r'^35(2[89]|[3-8][0-9])').hasMatch(cardNumber)) {
      return 'jcb';
    }
    // Okänt kort
    return null;
  }
}
