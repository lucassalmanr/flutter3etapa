class Filme {
  final int? id;
  final String titulo;
  final bool assistido;
  const Filme({this.id, required this.titulo, required this.assistido});
  Map<String, Object?> toMap() => {if (id != null) 'id': id, 'titulo': titulo, 'assistido': assistido ? 1 : 0};
  factory Filme.fromMap(Map<String, Object?> map) => Filme(id: (map['id'] as num).toInt(), titulo: map['titulo'] as String, assistido: (map['assistido'] as num).toInt() == 1);
  Filme copyWith({bool? assistido}) => Filme(id: id, titulo: titulo, assistido: assistido ?? this.assistido);
}
