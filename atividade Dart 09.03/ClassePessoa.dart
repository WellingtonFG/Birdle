class Pessoa {

  String nome;
  String cidade;
  String corFavorita;
  int idade;
  bool temCarro;

  Pessoa(this.nome, this.cidade, this.corFavorita, this.idade, this.temCarro);

  void mostrarDados() {
    print("Nome: $nome");
    print("Cidade: $cidade");
    print("Cor favorita: $corFavorita");
    print("Idade: $idade");

    if (temCarro) {
      print("Possui carro próprio: SIM");
    } else {
      print("Possui carro próprio: NAO");
    }

    print("__________________");
  }
}

void main() {

  Pessoa p1 = Pessoa("Wellington", "Cascavel", "Verde", 27, true);
  Pessoa p2 = Pessoa("Fellipe", "Toledo", "Azul", 23, false);

  p1.mostrarDados();
  p2.mostrarDados();
}