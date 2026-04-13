double calculoMediaPosicional(List<double> numeros) {
  double soma = 0;

  for(int i = 0; i < numeros.length; i++) {
    soma = soma + numeros[i];
  }

  return soma / numeros.length;
}

double calculoMediaNomeada({required List<double> numeros}) {
  double soma = 0;

  for(int i = 0; i < numeros.length; i++) {
    soma = soma + numeros[i];
  }

  return soma / numeros.length;
}

void main(){
  List<double> valores = [5, 14, 35, 28];

  double mediaPosicional = calculoMediaPosicional(valores);
  double mediaNomeada = calculoMediaNomeada(numeros: valores);

  print("Media posicional: $mediaPosicional");
  print("Media nomeada: $mediaNomeada");
}