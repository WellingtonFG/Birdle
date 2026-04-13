import 'package:flutter/material.dart';

void main() {
    runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
    const MeuApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.green,
                    title: const Center(
                        child: Text ("App Nome"),
                    ),
                ),
                body: const PaginaInicial(),
            ),
        );
        
    }
}

class PaginaInicial extends StatefulWidget {
    const PaginaInicial({super.key});

    @override
    State<PaginaInicial> createState() => PaginaInicialState();
}

    class HomePageState extends State<StatefulWidget> {
        Widget build(BuildContext context) {
            
        }
    }


    /* class PaginaInicialState extends State<PaginaInicial> {
        String texto = "Olá, meu povo!";
        int contador = 0;

        @override
        Widget build(BuildContext context) {
            return Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Text(texto),

                            const SizedBox(height: 20),

                            ElevatedButton(
                                child: const Text('Mudar texto'),
                                onPressed: () {
                                    setState(() {
                                        texto = "Texto Alterado $contador ${contador>1? "Vezes": "Vez"}!";
                                        contador++;
                                    });
                                }
                            ),
                        ]
                    ),
                    
                ),
            );
        }
    } */
