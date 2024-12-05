import 'package:flutter/material.dart';
import 'widgets/act_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Adicionando um ValueNotifier, para receber o tema enviado pelo botão
  final ValueNotifier<ThemeMode> _themeNotifier =
      ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Seu Nome Completo', // Alterado para o nome completo
          // Para remover a faixa de debug do app
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          // Adicionando o dark theme com cores verdes
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          // O tema será definido pelo botão
          themeMode: themeMode,
          home: MyHomePage(
            title: 'Seu Nome Completo', // Alterado para o nome completo
            themeNotifier: _themeNotifier,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.themeNotifier,
  });

  final String title;
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title), // Alterado para exibir o nome completo
      ),
      body: Column(
        // Adicionando o botão de trocar o tema do aplicativo
        children: [
          const Expanded(child: ActList()),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, themeMode, child) {
              return SwitchListTile(
                title: const Text("Ativar tema escuro"),
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
