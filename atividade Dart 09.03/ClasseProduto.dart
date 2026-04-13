class Produto {

  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);

  double calculoDesconto(double porcentagem) {
    double desconto = preco * porcentagem / 100;
    return preco - desconto;
  }

  double valorEstoqueTotal() {
    return preco * quantidade;
  }

  bool precisaReposicao() {
    if (quantidade < 5) {
      return true;
    } else {
      return false;
    }
  }
}