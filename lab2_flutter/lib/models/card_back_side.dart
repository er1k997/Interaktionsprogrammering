import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';

class CardBackSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardModel = Provider.of<CardModel>(context);

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Container(
        key: ValueKey('back'), // Nyckel för animation
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('images/23.jpeg'), // Samma bakgrund som framsidan
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Svart remsa (säkerhetsfält)
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                color: Colors.black,
              ),
            ),
            // CVV etikett och rektangel för CVV
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,  // Justera för att få texten längst till höger
                children: [
                  // CVV etikett
                  Text(
                    'CVV',
                    style: TextStyle(
                      fontSize: 12,  // Liten textstorlek för etiketten
                      color: const Color.fromARGB(255, 255, 254, 254),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4), // Litet avstånd mellan etikett och fält
                  // CVV nummer
                  Container(
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      cardModel.cvv.isNotEmpty ? cardModel.cvv : ' ',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Dynamisk logotyp längst ner till höger
            Positioned(
              bottom: 20,
              right: 20,
              child: Image.asset(
                'images/${cardModel.cardBrand}.png',
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
