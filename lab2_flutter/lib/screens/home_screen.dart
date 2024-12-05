import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';
import '../models/card_back_side.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // Hämta kortmodellen från provider
    final cardModel = Provider.of<CardModel>(context);

    // Definiera fokusnoder för att hantera fältens fokusstatus i formuläret.
    final FocusNode cardNumberFocus = FocusNode();
    final FocusNode cardHolderFocus = FocusNode();
    final FocusNode expiryMonthFocus = FocusNode();
    final FocusNode expiryYearFocus = FocusNode();
    final FocusNode cvvFocus = FocusNode(); // CVV fokus

    // Lyssnare för att uppdatera det aktiva fältet
    _addFocusListeners(cardModel, cardNumberFocus, cardHolderFocus, expiryMonthFocus, expiryYearFocus, cvvFocus);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBackground(),
          _buildForm(cardModel, cardNumberFocus, cardHolderFocus, expiryMonthFocus, expiryYearFocus, cvvFocus),
          _buildCardView(cardModel),
        ],
      ),
    );
  }

  // AppBar med bakgrundsfärg
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue[50],
    );
  }

  // Bakgrundsfärg för hela sidan
  Container _buildBackground() {
    return Container(
      color: Colors.blue[50], // Bakgrund för hela sidan, kan justeras eller tas bort
    );
  }

  // Bygger formulärsektionen som innehåller alla inputfält.
  Widget _buildForm(CardModel cardModel, FocusNode cardNumberFocus, FocusNode cardHolderFocus, FocusNode expiryMonthFocus, FocusNode expiryYearFocus, FocusNode cvvFocus) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 230), // Ger utrymme för kortet
      child: Container(
        color: Colors.blue[50],
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormContainer(cardModel, cardNumberFocus, cardHolderFocus, expiryMonthFocus, expiryYearFocus, cvvFocus),
          ],
        ),
      ),
    );
  }

  // Formulärens huvudcontainer som innehåller alla fält
  Container _buildFormContainer(CardModel cardModel, FocusNode cardNumberFocus, FocusNode cardHolderFocus, FocusNode expiryMonthFocus, FocusNode expiryYearFocus, FocusNode cvvFocus) {
    return Container(
      padding: EdgeInsets.fromLTRB(26, 80, 26, 86),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardNumberField(cardModel, cardNumberFocus),
          SizedBox(height: 10),
          _buildCardHolderField(cardModel, cardHolderFocus),
          SizedBox(height: 10),
          _buildExpiryDateFields(cardModel, expiryMonthFocus, expiryYearFocus),
          SizedBox(height: 10),
          _buildCVVField(cardModel, cvvFocus),
          _buildSubmitButton(cardModel),
        ],
      ),
    );
  }

  // Kortnummerfält - Uppdaterad
  TextField _buildCardNumberField(CardModel cardModel, FocusNode cardNumberFocus) {
  final isAmex = cardModel.cardBrand == 'amex'; // Kontrollera korttyp - om Amex
  return TextField(
    focusNode: cardNumberFocus,
    decoration: InputDecoration(
      labelText: 'Card Number',
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: cardModel.activeField == 'cardNumber' ? Colors.blue : Colors.grey,
        ),
      ),
    ),
    maxLength: isAmex ? 15 : 16, // Dynamiskt maxlängd
    keyboardType: TextInputType.number,
    onChanged: (value) {
      cardModel.updateCardNumber(value);
      },
    );
  }

  // Kortinnehavarfält
  TextField _buildCardHolderField(CardModel cardModel, FocusNode cardHolderFocus) {
    return TextField(
      focusNode: cardHolderFocus,
      decoration: InputDecoration(
        labelText: 'Card Holder',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: cardModel.activeField == 'cardHolder' ? Colors.blue : Colors.grey,
          ),
        ),
      ),
      maxLength: 24,
      onChanged: (value) {
        cardModel.updateCardHolder(value);
      },
    );
  }

  // Giltighetstid (Månad & År)
  Row _buildExpiryDateFields(CardModel cardModel, FocusNode expiryMonthFocus, FocusNode expiryYearFocus) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            focusNode: expiryMonthFocus,
            value: cardModel.expiryMonth,
            decoration: InputDecoration(
              labelText: 'Month',
              border: OutlineInputBorder(),
            ),
            items: cardModel.availableMonths.map((month) => DropdownMenuItem<String>(value: month, child: Text(month))).toList(),
            onChanged: (newMonth) {
              cardModel.updateExpiryDate(newMonth!, cardModel.expiryYear);
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            focusNode: expiryYearFocus,
            value: cardModel.expiryYear,
            decoration: InputDecoration(
              labelText: 'Year',
              border: OutlineInputBorder(),
            ),
            items: cardModel.availableYears.map((year) => DropdownMenuItem<String>(value: year, child: Text(year))).toList(),
            onChanged: (newYear) {
              cardModel.updateExpiryDate(cardModel.expiryMonth, newYear!);
            },
          ),
        ),
      ],
    );
  }

  // CVV-fält
  TextField _buildCVVField(CardModel cardModel, FocusNode cvvFocus) {
    return TextField(
      focusNode: cvvFocus,
      decoration: InputDecoration(
        labelText: 'CVV',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: cardModel.activeField == 'cvv' ? Colors.blue : Colors.grey,
          ),
        ),
      ),
      obscureText: true,
      maxLength: 3,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        cardModel.updateCVV(value);
      },
    );
  }

  // Submit Button
  Widget _buildSubmitButton(CardModel cardModel) {
    return GestureDetector(
      onTapDown: (_) {
        cardModel.setActiveField('submit');
      },
      onTapUp: (_) {
        cardModel.setActiveField('');
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: cardModel.activeField == 'submit' ? const Color.fromARGB(255, 96, 120, 144) : Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Lägger till lyssnare på varje fokusnod för att uppdatera vilket fält som är aktivt.
  void _addFocusListeners(CardModel cardModel, FocusNode cardNumberFocus, FocusNode cardHolderFocus, FocusNode expiryMonthFocus, FocusNode expiryYearFocus, FocusNode cvvFocus) {
    cardNumberFocus.addListener(() {
      cardModel.setActiveField(cardNumberFocus.hasFocus ? 'cardNumber' : '');
    });

    cardHolderFocus.addListener(() {
      cardModel.setActiveField(cardHolderFocus.hasFocus ? 'cardHolder' : '');
    });

    expiryMonthFocus.addListener(() {
      cardModel.setActiveField(expiryMonthFocus.hasFocus ? 'expiryMonth' : '');
    });

    expiryYearFocus.addListener(() {
      cardModel.setActiveField(expiryYearFocus.hasFocus ? 'expiryYear' : '');
    });

    cvvFocus.addListener(() {
      cardModel.setActiveField(cvvFocus.hasFocus ? 'cvv' : '');
    });
  }

  // Kreditkortsvy (Front / Back)
  Positioned _buildCardView(CardModel cardModel) {
    return Positioned(
      top: 30,
      left: 16,
      right: 16,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: cardModel.activeField == 'cvv'
              ? CardBackSide() // Baksidan visas
              : _buildCardFront(cardModel),
        ),
      ),
    );
  }

  // Front-sidan av kortet
  Widget _buildCardFront(CardModel cardModel) {
    return Container(
      key: ValueKey('front'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('images/23.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          _buildCardChip(),
          _buildCardBrand(cardModel),
          _buildCardNumberOverlay(cardModel),
          _buildCardHolder(cardModel),
          _buildCardExpiry(cardModel),
        ],
      ),
    );
  }

  // Chip-bild på kortet
  Positioned _buildCardChip() {
    return Positioned(
      top: 16,
      left: 16,
      child: Image.asset(
        'images/chip.png',
        height: 40,
        width: 40,
      ),
    );
  }

  // Dynamisk kortlogotyp
  Positioned _buildCardBrand(CardModel cardModel) {
    return Positioned(
      top: 16,
      right: 16,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
              opacity: animation, child: child);
        },
        child: Image.asset(
          'images/${cardModel.cardBrand}.png',
          key: ValueKey(cardModel.cardBrand),
          height: 40,
          width: 40,
        ),
      ),
    );
  }

  // Kortnummer med rektangulär markering
  Align _buildCardNumberOverlay(CardModel cardModel) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: cardModel.activeField == 'cardNumber' ? Colors.white : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(4),
        child: Text(
          cardModel.cardNumber,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 7,
          ),
        ),
      ),
    );
  }

  // Kortinnehavare
  Positioned _buildCardHolder(CardModel cardModel) {
    return Positioned(
      bottom: 16,
      left: 16,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: cardModel.activeField == 'cardHolder' ? Colors.white : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Card Holder",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            Text(
              cardModel.cardHolder,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Giltighetstid
  Positioned _buildCardExpiry(CardModel cardModel) {
  return Positioned(
    bottom: 16,
    right: 16,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: cardModel.activeField == 'expiryMonth' || cardModel.activeField == 'expiryYear' ? Colors.white : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Text(
            "Expires",
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            "${cardModel.expiryMonth}/${cardModel.expiryYearShort}", // Kort år - två siffror
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
}
