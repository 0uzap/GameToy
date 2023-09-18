import 'package:flutter/material.dart';
import 'package:flutter_application_1/TicTacToe.dart';
import 'package:flutter_application_1/Taquin.dart';

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



