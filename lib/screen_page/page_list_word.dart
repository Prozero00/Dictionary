import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamus/model/model_word.dart';
import 'package:http/http.dart' as http;
import 'package:kamus/screen_page/page_login.dart';

import '../utils/check_session.dart';

class PageListWord extends StatefulWidget {
  const PageListWord({super.key});

  @override
  State<PageListWord> createState() => _PageListWordState();
}

class _PageListWordState extends State<PageListWord> {
  static Future<ModelWord> fetchMeaning(String word) async {
    http.Response res = await http.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return ModelWord.fromJson(data[0]);
    } else {
      throw Exception("Failed to load meaning");
    }
  }

  bool isLoading = true;
  ModelWord? listWord;
  List<String> listDefaultWord = [
    "Apple",
    "Banana",
    "Cat",
    "Car",
    "Duck",
    "Egg",
    "Fog",
    "Guy",
    "Hoe",
    "Infant",
    "Joke",
    "Knee",
    "Love",
    "Moron",
    "Nuke",
    "Nut",
    "Orange",
    "Orphan",
    "One",
    "Pioneer",
    "Queue",
    "Result",
    "Stroke",
    "Top",
    "Unit",
    "Value",
    "Wall",
    "Wol",
    "X-ray",
    "Youth",
    "Zebra",
    "Zero",
  ];
  String noDataText = "Welcome to Dictionary, Start Searching";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color to your desired color
          ),
          title: Text(
            "Dictionary",
            style: GoogleFonts.merriweather(
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(102, 102, 255, 1), Colors.purple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          centerTitle: true,
          leading: ModalRoute.of(context)?.settings.name != '/page_list_word'
              ? IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PageListWord()),
                    (route) => false,
              );
            },
            icon: Icon(Icons.arrow_back),
          )
              : null,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  session.clearSession();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PageLogin()),
                      (route) => false);
                });
              },
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _searchBar(),
                  const SizedBox(height: 16),
                  if (isLoading)
                    _home()
                  else if (listWord != null)
                    Expanded(child: _responseWidget())
                  else
                    Text(
                      textAlign: TextAlign.center,
                      "The word that you search are not found",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                ],
              )),
        ));
  }

  _responseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          listWord!.word!,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Text(
          listWord!.phonetic ?? "",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return _meaningsWidget(listWord!.meanings![index]);
          },
          itemCount: listWord!.meanings!.length,
        ))
      ],
    );
  }

  _meaningsWidget(Meanings meanings) {
    String definitionList = "";
    meanings.definitions?.forEach(
      (element) {
        int index = meanings.definitions!.indexOf(element);
        definitionList += "\n${index + 1}. ${element.definition}\n";
      },
    );

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meanings.partOfSpeech!,
              style: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Definitions : ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(definitionList),
            _buildSet("Synonyms", meanings.synonyms),
            _buildSet("Antonyms", meanings.antonyms),
          ],
        ),
      ),
    );
  }

  _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(setList!
              .toSet()
              .toString()
              .replaceAll("{", "")
              .replaceAll("}", "")),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _home() {
    return Expanded(
      child: ListView.builder(
          itemCount: listDefaultWord.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              PageDetailWord(listDefaultWord[index])));
                },
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        listDefaultWord[index] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }

  _searchBar() {
    return SearchBar(
      hintText: "Search word here",
      onSubmitted: (value) {
        _getMeaning(value);
      },
    );
  }

  _getMeaning(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      listWord = await fetchMeaning(word);
      setState(() {});
    } catch (e) {
      listWord = null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class PageDetailWord extends StatefulWidget {
  final String word;

  PageDetailWord(this.word, {Key? key}) : super(key: key);

  @override
  State<PageDetailWord> createState() => _PageDetailWordState();
}

class _PageDetailWordState extends State<PageDetailWord> {
  bool isLoading = true;
  ModelWord? listWord;

  @override
  void initState() {
    super.initState();
    _getMeaning(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color to your desired color
          ),
          title: Text(
            "Dictionary",
            style: GoogleFonts.merriweather(
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromRGBO(102, 102, 255, 1), Colors.purple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchBar(),
                const SizedBox(height: 8),
                Expanded(
                  child: _responseWidget(),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _searchBar() {
    return SearchBar(
      hintText: "Search word here",
      onSubmitted: (value) {
        _getMeaning(value);
      },
    ); // Replace this with your SearchBar widget
  }

  Future<void> _getMeaning(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedWord = await fetchMeaning(word);
      setState(() {
        listWord = fetchedWord;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        listWord = null;
        isLoading = false;
      });
    }
  }

  Future<ModelWord> fetchMeaning(String word) async {
    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ModelWord.fromJson(data[0]);
    } else {
      throw Exception('Failed to load meaning');
    }
  }

  Widget _responseWidget() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (listWord != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            listWord!.word!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            listWord!.phonetic ?? "",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _meaningsWidget(listWord!.meanings![index]);
              },
              itemCount: listWord!.meanings!.length,
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Text(
          "The word '${widget.word}' is not found",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      );
    }
  }

  Widget _meaningsWidget(Meanings meanings) {
    String definitionList = "";
    meanings.definitions?.forEach((element) {
      int index = meanings.definitions!.indexOf(element);
      definitionList += "\n${index + 1}. ${element.definition}\n";
    });

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meanings.partOfSpeech!,
              style: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Definitions : ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(definitionList),
            _buildSet("Synonyms", meanings.synonyms),
            _buildSet("Antonyms", meanings.antonyms),
          ],
        ),
      ),
    );
  }

  Widget _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(setList!
              .toSet()
              .toString()
              .replaceAll("{", "")
              .replaceAll("}", "")),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
