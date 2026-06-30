import 'package:flutter/material.dart';
import 'pages/splash/splash_page.dart';

void main() {
  // Garante que as propriedades nativas (como canais de GPS e SQLite) 
  // sejam devidamente inicializadas antes do app rodar.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppClima());
}

class AppClima extends StatelessWidget {
  const AppClima({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      debugShowCheckedModeBanner: false, // Remove a faixa de debug do canto da tela
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // O app inicia obrigatoriamente pela SplashPage para rodar a lógica de geolocalização
      home: const SplashPage(), 
    );
  }
}