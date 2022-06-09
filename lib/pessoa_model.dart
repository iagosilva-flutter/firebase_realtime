// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pessoa {
  String? id;
  String nome;
  int like;
  Pessoa({
    required this.nome,
    required this.like,
    this.id,
  });
}
