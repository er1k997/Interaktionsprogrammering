import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleFlutterScreen(), // The first screen of the app, displayed when the app starts
    );
  }
}

class ExampleFlutterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(  // Kompletering,för att fixa pixel-overflow i y-led.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(),
              // const SizedBox(height: 10), // Om du vill ha extra utrymme
              _buildButtonGrid(),
              // const SizedBox(height: 10),
              _buildEmailInputField(),
            ],
          ),
        ),
      ),
    );
  }

  // Titel Section
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 22, 94, 52),
      title: const Text(
        'Example Flutter',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Display Image 
  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Image.asset(
        'assets/circle.png',
        width: 140,
        height: 140,
        fit: BoxFit.cover,  // Ensures the image fills the container while maintaining its aspect ratio, cropping if necessary.
      ),
    );
  }

  // Button grid widget
  Widget _buildButtonGrid() {
    return GridView.builder(
      shrinkWrap: true, // helps to avoid expanding beyond its necessary size and thus avoids pushing out the other widgets in your layout.
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  // Defines the layout of the grid
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 70,
        childAspectRatio: 2.0,                               // Controls the width-to-height ratio of the buttons 
      ),
      padding: const EdgeInsets.all(100),
      itemBuilder: (context, index) => _buildGridButtons(),  // Builds each individual button
    );
  }

  // Individual button widget
  Widget _buildGridButtons() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Text(  // The content inside the button is a Text widget
        'BUTTON',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  // Email input field 
  Widget _buildEmailInputField() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20), // Lägger till vänster- och höger-padding
    child: TextField(
      decoration: InputDecoration(
        // Här definieras etikettens text
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 175, 176, 176),
        ),
        // Undersökningen för att skapa linjen, och ställ in färgen
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 189, 78, 78)), // Linjefärgen
        ),
      ),
      keyboardType: TextInputType.emailAddress, // Sätter rätt tangentbordstyp
    ),
  );
}

}
