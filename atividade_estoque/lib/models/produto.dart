class Produto {
  const Produto({
    this.id,
    required this.nome,
    required this.categoria,
    required this.quantidade,
    required this.preco,
  });
  final int? id;
  final String nome;
  final String categoria;
  final int quantidade;
  final double preco;
  factory Produto.fromMap(Map<String, Object?> map) => Produto(
    id: map['id'] as int?,
    nome: map['nome'] as String,
    categoria: map['categoria'] as String,
    quantidade: map['quantidade'] as int,
    preco: (map['preco'] as num).toDouble(),
  );
  Map<String, Object?> toMap() => {
    'nome': nome,
    'categoria': categoria,
    'quantidade': quantidade,
    'preco': preco,
  };
}
