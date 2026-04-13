import 'ClasseProduto.dart';

double calculoTotalLista(List<Produto> produtos) {

  double total = 0;

  for (int i = 0; i < produtos.length; i++) {
    total = total + produtos[i].valorEstoqueTotal();
  }

  return total;
}

void main() {

  List<Produto> produtos = [
    Produto("Camiseta", 85, 8),
    Produto("Tenis", 220, 2),
    Produto("Boné", 55, 5),
    Produto("Relógio", 130, 3)

  ];

  for (int i = 0; i < produtos.length; i++) {

    print("Nome: ${produtos[i].nome}");
    print("Valor total em estoque: ${produtos[i].valorEstoqueTotal()}");

    if (produtos[i].precisaReposicao()) {
      print("Precisa reposicao: SIM");
    } else {
      print("Precisa reposicao: NAO");
    }

    print("--------------------");
  }

  double total = calculoTotalLista(produtos);

  print("Valor total de todos os produtos: $total");
}