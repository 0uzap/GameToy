import 'package:flutter/material.dart';


class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  static const String joueur_X = "X";  
  static const String joueur_O = "O";
  // static pour que la varibale appartienne a la classe plutôt qu'a une instance, pas besoin d'une instance a chaque fois


  late String joueurActu;
  late bool fin;
  late List<String> plateau;
  // late permet de déclarer une variable mais de leurs attribuer une valeur plus tard

  @override
  void initState() {
    gameInitialise();
    super.initState();
  }

  void gameInitialise() {
    joueurActu = joueur_X;
    fin = false;
    plateau = ["", "", "", "", "", "", "", "", "",]; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TicTacToe',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _header(),
            _jeux(),
            _rejouer(),
          ],
        ),
      ),
    );
  }
  // le _ devant header/jeux/column dis qu'il est privé à la classe TicTacToe et donc on peut pas l'utiliser ailleur
  
  Widget _header() {
    return Column(
      children: [
        Text(
          "Joueur : $joueurActu",
          style: TextStyle(
            color: Colors.amberAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _jeux() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),// création de la grille de taille 3x3
          itemCount: 9, // nombre de box
        itemBuilder: ((context, int index) {
          return _box(index); //creation des box
        })),
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
          gameInitialise();
        });
      }),
      child: Text(
        "nouvelle partie",
        style: TextStyle(
          color: Colors.green, 
          fontSize: 25,
        )
      )
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: (() {
        if (fin || plateau[index].isNotEmpty) {
          return; // si partie fini ou zone pleine on peut pas changer la valeur
        }
        setState(() {
          plateau[index] = joueurActu;

          tour();
          victoire();
          matchNul();
        });
      }),
      child:  Container(
        color: Colors.blue,
        margin: const EdgeInsets.all(5),
        child: Center(
          child: Text(
            plateau[index],
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 192, 192, 192),
            ),
          ),
        ),
      ),
    );
  }

  tour() {
    if (joueurActu == "X") {
      joueurActu = joueur_O;
    } else {
      joueurActu = joueur_X;
    }
  }

  victoire() {
    List<List<int>> solution = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var solutionP in solution) {
      String position0 = plateau[solutionP[0]];
      String position1 = plateau[solutionP[1]];
      String position2 = plateau[solutionP[2]];

      if (position0.isNotEmpty) {
        if (position0 == position1 && position0 == position2) { // vérif des valeurs de chaque position, si elle sont égale le joueur x ou o gagne
          messageFin("Le joueur $position0 a gagner ! Léficitation !");
          fin = true;
          return;
        }
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
            fontSize: 24, color:  Colors.white
          ),      
        ),
        backgroundColor: Colors.black,
      )
    );
  }

  matchNul() {
    if (fin) {
      return;
    }
    bool nul = true;
    for (var plateauPosi in plateau) {
      if (plateauPosi.isEmpty) {
        nul = false;
      }
    }
    if (nul) {
      fin = true;
      messageFin("Match null | Faudrais recommencer");
    }
  }


}