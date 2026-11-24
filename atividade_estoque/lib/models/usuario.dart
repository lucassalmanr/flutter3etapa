class Usuario {
  const Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });
  final int? id;
  final String nome;
  final String email;
  final String senha;
  factory Usuario.fromMap(Map<String, Object?> map) => Usuario(
    id: map['id'] as int?,
    nome: map['nome'] as String,
    email: map['email'] as String,
    senha: map['senha'] as String,
  );
  Map<String, Object?> toMap() => {
    'nome': nome,
    'email': email,
    'senha': senha,
  };
}
