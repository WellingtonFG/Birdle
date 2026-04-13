void main() {
  print('Olá, mundo!');

  String day_of_the_week = 'Quarta';

  switch(day_of_the_week) {
    case 'Segunda':
      print('Hoje é segunda-feira.');
      break;
    case 'Terça':
      print('Hoje é terça-feira.');
      break;
    case 'Quarta':
      print('Hoje é quarta-feira.');
      break;
    case 'Quinta':
      print('Hoje é quinta-feira.');
      break;
    case 'Sexta':
      print('Hoje é sexta-feira.');
      break;
    case 'Sabado':
      print('Hoje é sábado.');
      break;
    case 'Domingo':
      print('Hoje é domingo.');
      break;
    default:
      print('Dia da semana inválido.');
  }
}