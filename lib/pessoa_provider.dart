import 'dart:convert';

import 'package:firebase_realtime/pessoa_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PessoaProvider extends ChangeNotifier {
  final urlRealtimeDatabase = 'SUA_URL/pessoa';

  // "SUA_URL" substitua esse trecho com a url do seu realtime databse no firestore
  // "/pessoa" é o nome da coleção que vai ser criada

  final List<Pessoa> _pessoas = [];

  List<Pessoa> get pessoas => [..._pessoas];

  Future<void> addPessoa(String nome) async {
    await http.post(
      Uri.parse('$urlRealtimeDatabase.json'),
      body: jsonEncode(
        {
          "nome": nome,
          "like": 0,
        },
      ),
    );
    loadPessoas();
  }

  Future<void> addLike(int index) async {
    Pessoa p = _pessoas[index];
    await http.patch(Uri.parse('$urlRealtimeDatabase/${p.id}.json'),
        body: jsonEncode({"like": p.like + 1}));
    loadPessoas();
  }

  Future<void> delPessoa(int index) async {
    String id = _pessoas[index].id!;
    await http.delete(Uri.parse('$urlRealtimeDatabase/$id.json'));
    loadPessoas();
  }

  Future<void> loadPessoas() async {
    _pessoas.clear();
    final r = await http.get(
      Uri.parse('$urlRealtimeDatabase.json'),
    );
    if (r.body == 'null') return;
    Map<String, dynamic> dados = jsonDecode(r.body);
    dados.forEach((key, value) {
      _pessoas.add(
        Pessoa(
          id: key,
          nome: value['nome'],
          like: value['like'],
        ),
      );
    });
    notifyListeners();
  }
}
