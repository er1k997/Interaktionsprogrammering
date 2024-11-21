package com.example.lab_1_kc

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.* // För Material 3-komponenter
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.lab_1_kc.ui.theme.Lab_1_KCTheme
// import com.example.lab_1_kc.R


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Lab_1_KCTheme {
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
                    MainScreen()
                }
            }
        }
    }
}

@Preview
@Composable
fun MainScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(0.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Bakgrund för översätta symboler
        Text(
            text = "",
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFF48754B))
                .padding(4.dp)
        )

        // Rubrik
        Text(
            text = "Kotlin + Compose",
            fontSize = 24.sp,
            color = Color.White,
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFF2A5B2E))
                .padding(20.dp)
        )

        Spacer(modifier = Modifier.height(16.dp))   // Skapar mellanrum för samtrliga komponterer

        // Bild (lägg till en bild i res/drawable för att använda här)
        Image(
            painter = painterResource(id = R.drawable.circle),
            contentDescription = null,
            modifier = Modifier
                .size(200.dp)
                .padding(16.dp),
            contentScale = ContentScale.Crop
        )

        Spacer(modifier = Modifier.height(16.dp))

        // Fyra knappar med grå bakgrund
        Row(
            horizontalArrangement = Arrangement.SpaceEvenly,
            modifier = Modifier.fillMaxWidth()
        ) {
            Button(
                onClick = { /* Do something */ },
                colors = ButtonDefaults.buttonColors(containerColor = Color.Gray)
            ) {
                Text("BUTTON")
            }
            Button(
                onClick = {  },
                colors = ButtonDefaults.buttonColors(containerColor = Color.Gray)
            ) {
                Text("BUTTON")
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        Row(
            horizontalArrangement = Arrangement.SpaceEvenly,
            modifier = Modifier.fillMaxWidth()
        ) {
            Button(
                onClick = { },
                colors = ButtonDefaults.buttonColors(containerColor = Color.Gray)
            ) {
                Text("BUTTON")
            }
            Button(
                onClick = {  },
                colors = ButtonDefaults.buttonColors(containerColor = Color.Gray)
            ) {
                Text("BUTTON")
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Inmatningsruta för e-post
        var email by remember { mutableStateOf(TextFieldValue("")) }
        OutlinedTextField(
            value = email,                      // Fältets aktuella text.
            onValueChange = { email = it },     // Uppdaterar variabeln email när texten ändras.
            label = { Text("Email") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp)
        )
    }
}
