import 'package:flutter/material.dart';
import 'package:flutter_application_1/TicTacToe.dart';
import 'package:flutter_application_1/Taquin.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          "GameToy"
          )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'GameToy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('TicTacToe'),
              
            ),
            ListTile(title: Text('Taquin'),
              
            ),
          ],
        )
      ),
      body: const Center(
        child: TexteButton(),
      ),
    );
  }
}

class TexteButton extends StatelessWidget {
  const TexteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TicTacToe()),
            );
          },
          child: const Text("TicTacToe"),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Taquin()),
            );
          },
          child: const Text("Taquin"),
          ),
      ],
    );
  }
}



