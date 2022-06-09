import 'package:firebase_realtime/pessoa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pessoa_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PessoaProvider>(context);

    final List<Pessoa> pessoas = provider.pessoas;

    _addName() {
      String nome = 'Sem Nome';
      if (nameController.text.isNotEmpty) {
        nome = nameController.text;
      }
      provider.addPessoa(nome);
      nameController.clear();
    }

    _addLike(int index) {
      provider.addLike(index);
    }

    _delPessoa(int index) {
      provider.delPessoa(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(child: Text('CRUD FIREBASE REALTIME')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
            ),
            ElevatedButton.icon(
              label: const Text('Adicionar'),
              icon: const Icon(Icons.add),
              onPressed: _addName,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pessoas.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(pessoas[index].nome),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(pessoas[index].like.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            _addLike(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _delPessoa(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
