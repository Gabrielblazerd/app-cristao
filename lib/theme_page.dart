import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;

class ThemePage extends StatefulWidget {
  final String theme;

  ThemePage({Key? key, required this.theme}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  List<String> verses = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchVerses();
  }

  Future<void> fetchVerses() async {
    try {
      // Nome do arquivo deve estar em letras minúsculas, sem acentos ou cedilha
      String themeFileName = widget.theme
          .toLowerCase()
          .replaceAll('ç', 'c')
          .replaceAll('ã', 'a')
          .replaceAll('á', 'a')
          .replaceAll('é', 'e')
          .replaceAll('ê', 'e')
          .replaceAll('í', 'i')
          .replaceAll('ó', 'o')
          .replaceAll('ô', 'o')
          .replaceAll('ú', 'u');

      // Carregando o arquivo JSON correspondente ao tema
      final String data = await root_bundle.rootBundle
          .loadString('assets/biblia_nvi/$themeFileName.json');
      final List<dynamic> jsonResult = json.decode(data);

      setState(() {
        verses = jsonResult
            .map((verse) =>
                "${verse['livro'] ?? 'Livro desconhecido'} ${verse['capitulo']}:${verse['versiculo']}\n${verse['texto'] ?? 'Versículo não encontrado'}")
            .toList();
      });
    } catch (e) {
      setState(() {
        verses = ['Não foi possível carregar os versículos.'];
      });
    }
  }

  void showNextVerse() {
    setState(() {
      currentIndex = (currentIndex + 1) % (verses.isEmpty ? 1 : verses.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.theme),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verses.isEmpty
                ? const Text(
                    'Carregando...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    children: [
                      Text(
                        verses[currentIndex].split('\n')[0],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        verses[currentIndex].split('\n')[1],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showNextVerse,
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}
