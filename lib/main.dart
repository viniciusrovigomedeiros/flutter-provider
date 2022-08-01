import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

final pessoaController = ChangeNotifierProvider(
  (ref) => PessoaController(),
);

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pessoaControler = ref.watch(pessoaController);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              color: Colors.amber,
              child: Center(
                child: Text(
                  '${pessoaControler.people.nome} tem ${pessoaControler.people.idade} anos de idade',
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => nextPage()));
                },
                child: const Text('Próxima tela')),
          ],
        ),
      ),
    );
  }
}

class nextPage extends HookConsumerWidget {
  const nextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pessoaControler = ref.watch(pessoaController);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            child: Center(child: Text(pessoaControler.people.nome)),
          ),
          ElevatedButton(
            onPressed: () {
              pessoaControler.setPessoa('Ronaldo', 22);
            },
            child: const Text('Trocar nome'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: const Text('Voltar para tela inicial'))
        ],
      ),
    );
  }
}

class Pessoa {
  String nome;
  int idade;

  Pessoa(this.nome, this.idade);
}

class PessoaController extends ChangeNotifier {
  Pessoa people = Pessoa('Adriano', 25);

  void setPessoa(String name, int idade) {
    people.idade = idade;
    people.nome = name;
    notifyListeners();
  }
}
