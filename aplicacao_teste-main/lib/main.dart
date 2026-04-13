import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 53, 167),
          title: Center(
            child: Text("AppNome")
          )
        ),

        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Olá, meu povo!"),
              Icon(Icons.add_sharp, color: const Color.fromARGB(255, 41, 53, 160)),
            ],
          ),
        ),

        /*body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Olá, meu povo!"),
              Text("23/03/2026")
            ],
          ),
        ),*/

        /* body: Center (
          child: Text("Olá, mundo!" "\n23/03/2026",
            style: TextStyle(
              fontSize: 30,
              color: const Color.fromARGB(255, 22, 65, 21),
              fontWeight: FontWeight.bold
            )
          )
        )*/
      ),
    ),
  );
}