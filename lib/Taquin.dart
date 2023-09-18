import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Taquin extends StatefulWidget {
  const Taquin({super.key});

  @override
  State<Taquin> createState() => _TaquinState();
}

class _TaquinState extends State<Taquin> {
  var grille = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  late bool fin;

  @override
  void initState() {
    super.initState();
    gameInit();
  }

  void gameInit() {
    fin = false;
  }

  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Taquin',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _game(taille),
              _rejouer(),
            ],
          ),
        )
      ) ,
    );
  }

  Widget _game(taille) {
    return Container(
      margin: EdgeInsets.all(10),
      height: taille.height * 0.6,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: grille.length,
        itemBuilder: (context, index) {
          final grilles = grille[index];
          return grille[index] != 0
            ? _box(index, taille, grilles)
            : Container();
        },
      ),
    );
  }

  victoire() {
    var solution1 =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
    var solution2 = [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];

    if (listEquals(grille, solution1) == true || listEquals(grille, solution2) == true) {
      messageFin("Léficitations !");
      fin = true;
      return;
    }
  }

  mouvement(int index) {
    if (fin == false) {
      if (index - 1 >= 0 && grille[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && grille[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && grille[index - 4] == 0) ||
        (index + 4 < 16 && grille[index + 4] == 0)) {
          grille[grille.indexOf(0)] = grille[index];
          grille[index] = 0;
        }
    }
  }

  messageFin(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Fin de la partie \n $message",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      )
    );
  }

  Widget _box(index, taille, grilles) {
    return InkWell(
      onTap: (() {
        if (fin) {
          return; // si partie fini, peut plus changer les valeurs
        }
        setState(() {
          mouvement(index);
          victoire();
        });
      }),
      child: Container(
        margin: EdgeInsets.all(1),
        height: taille.height * 0.6,
        color: Colors.blue,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "$grilles",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _rejouer() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      onPressed: (() {
        setState(() {
          gameInit();
        });
      }),
      child: Text(
        "Nouvelle partie",
        style: TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }


}