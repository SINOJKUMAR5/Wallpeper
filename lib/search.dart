import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'full.dart';

class search extends StatefulWidget {
  final String text;

  const search({super.key, required this.text});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    search_api(widget.text);
  }

  search_api(text) async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$text&per_page=100"),
        headers: {
          'Authorization':
              'bRCnV0vbMsyvn4xxAyxATa2BbzhezlaL5b257BdObLVGMxqZsnZZAZVe'
        }).then((value) {
      print(value.body);
      Map result = jsonDecode(value.body);

      setState(() {
        images = result['photos'];
      });
    });
  }

  load_page(text) async {
    setState(() {
      page = page + 1;
    });

    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$text&per_page=100&page=" +
                page.toString()),
        headers: {
          'Authorization':
              'bRCnV0vbMsyvn4xxAyxATa2BbzhezlaL5b257BdObLVGMxqZsnZZAZVe'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => full(
                                    imageUrl: images[index]['src']['large2x'],
                                  )));
                    },
                    child: Container(
                      color: Colors.black,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          ),
          TextButton(
              onPressed: () {
                load_page(widget.text);
              },
              child: Text("load"))
        ],
      ),
    );
  }
}
