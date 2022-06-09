import 'package:firebase_realtime/pessoa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PessoaProvider()),
      ],
      child: MaterialApp(
        title: 'Exemplo Firebase',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
