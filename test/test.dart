import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:math';

void main() {
  runApp(ChristianApp());
}

class ChristianApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicativo Cristão',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dailyPhrase = 'Carregando...';
  final List<String> themes = [
    'Amor',
    'Salvação',
    'Fé',
    'Esperança',
    'Sabedoria',
    'Oração'
  ];

  @override
  void initState() {
    super.initState();
    fetchDailyPhrase();
  }

  Future<void> fetchDailyPhrase() async {
    try {
      final data =
          await rootBundle.rootBundle.loadString('assets/biblia_nvi/amor.json');
      final jsonResult = json.decode(data);
      final randomIndex = Random().nextInt(jsonResult.length);
      setState(() {
        dailyPhrase = jsonResult[randomIndex]['texto'];
      });
    } catch (e) {
      setState(() {
        dailyPhrase = 'Não foi possível carregar a frase diária.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.blue[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Frase Diária: "$dailyPhrase"',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children:
                    themes.map((theme) => ThemeBox(theme: theme)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChurchPage(),
                    ),
                  );
                },
                child: Text('Qual Igreja Ir?'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeBox extends StatelessWidget {
  final String theme;

  ThemeBox({required this.theme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThemePage(theme: theme),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            theme,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ThemePage extends StatefulWidget {
  final String theme;

  ThemePage({required this.theme});

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
      // Aqui, ajustamos o nome do arquivo para não ter acentuação.
      final String themeFileName = widget.theme
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

      final data = await rootBundle.rootBundle
          .loadString('assets/biblia_nvi/$themeFileName.json');
      final jsonResult = json.decode(data);
      setState(() {
        verses = List<Map<String, dynamic>>.from(jsonResult)
            .map((verse) =>
                "${verse['livro'] ?? 'Livro desconhecido'} ${verse['capitulo'].toString()} : ${verse['versiculo'].toString()} - ${verse['texto'] ?? 'Versículo não encontrado'}")
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
            Text(
              verses.isEmpty ? 'Carregando...' : verses[currentIndex],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showNextVerse,
              child: Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChurchPage extends StatefulWidget {
  @override
  _ChurchPageState createState() => _ChurchPageState();
}

class _ChurchPageState extends State<ChurchPage> {
  String churchInfo = 'Carregando...';

  @override
  void initState() {
    super.initState();
    fetchChurchInfo();
  }

  Future<void> fetchChurchInfo() async {
    try {
      final data = await rootBundle.rootBundle
          .loadString('assets/info/igreja_info.json');
      final jsonResult = json.decode(data);
      setState(() {
        churchInfo = jsonResult['info'];
      });
    } catch (e) {
      print('Erro ao carregar as informações: $e');
      setState(() {
        churchInfo = 'Não foi possível carregar as informações.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Igrejas Próximas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              churchInfo,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
