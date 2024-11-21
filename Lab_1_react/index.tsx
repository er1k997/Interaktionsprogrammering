import React from 'react';
import { View, Text, Image, TouchableOpacity, TextInput, StyleSheet } from 'react-native';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      {/* Rubrik */}
      <Text style={styles.title}>React Native</Text>

      {/* Bild */}
      <Image
        source={require('@/assets/images/circle.png')} // Byt till din bild här
        style={styles.image}
      />

      {/* Knappar - två kolumner */}
      <View style={styles.buttonContainer}>
        <View style={[styles.button, styles.leftButton]}>
          <TouchableOpacity style={styles.buttonStyle} onPress={() => {}}>
            <Text style={styles.buttonText}>BUTTON 1</Text>
          </TouchableOpacity>
        </View>
        <View style={[styles.button, styles.rightButton]}>
          <TouchableOpacity style={styles.buttonStyle} onPress={() => {}}>
            <Text style={styles.buttonText}>BUTTON 2</Text>
          </TouchableOpacity>
        </View>
        <View style={[styles.button, styles.leftButton]}>
          <TouchableOpacity style={styles.buttonStyle} onPress={() => {}}>
            <Text style={styles.buttonText}>BUTTON 3</Text>
          </TouchableOpacity>
        </View>
        <View style={[styles.button, styles.rightButton]}>
          <TouchableOpacity style={styles.buttonStyle} onPress={() => {}}>
            <Text style={styles.buttonText}>BUTTON 4</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Textinmatningsruta */}
      <View style={styles.inputContainer}>
        <Text style={styles.inputLabel}>Email</Text>
        <TextInput style={styles.input} placeholder="Skriv här" />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#FFFFFF',
  },

  title: {
    fontSize: 24,
    fontWeight: 'bold',
    paddingTop: 20,  // Add padding to the top for space above the text
    paddingBottom: 20, // Add padding to the bottom for space below the text
    paddingLeft: 20,
    color: '#ffffff',
    backgroundColor: '#4CAF50',
    width: '100%',
    textAlign: 'left',
  },
  image: {
    width: 150,
    height: 150,
    marginBottom: 40,
    alignSelf: 'center',
    marginTop: 30,
  },
  buttonContainer: {
    flexDirection: 'row',           // Placera Text och TextInput horisontellt
    flexWrap: 'wrap', 
    justifyContent: 'space-around', 
    width: '60%',
    marginBottom: 20,
    alignSelf: 'center',
  },
  button: {
    width: '40%',
    margin: 10,
  },
  leftButton: {
    marginLeft: -20, 
  },
  rightButton: {
    marginRight: -20, 
  },
  buttonStyle: {
    backgroundColor: '#d6d5d5',  
    paddingVertical: 10,          // Vertikal padding
    borderRadius: 5,             // Rundade hörn
    alignItems: 'center',        // Centrerar texten horisontellt
    justifyContent: 'center',    // Centrerar texten vertikalt
  },
  buttonText: {
    color: '#202020',            
    fontSize: 16,                
    fontWeight: 'bold',          
  },
  inputContainer: {
    flexDirection: 'row',        
    alignItems: 'center',        // Justera vertikalt för att centrera på samma nivå
    width: '80%',
    marginTop: 20,
    textAlign: 'left',
  },
  inputLabel: {
    marginRight: 70,             // Lägg till lite avstånd mellan etiketten och inputfältet
    fontSize: 16,
    marginLeft: 15,
  },
  input: {
    height: 40,
    borderColor: '#9C27B0',
    borderBottomWidth: 1,       // Tjocklek på linje
    paddingLeft: 10,
    marginTop: 5,
    width: '80%',  
  },
});
