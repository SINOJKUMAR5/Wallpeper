import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpepar/widget.dart';

import 'full.dart';

class city extends StatefulWidget {
  final app_name;

  const city({Key? key, required this.app_name}) : super(key: key);

  @override
  State<city> createState() => _cityState();
}

class _cityState extends State<city> {
  List city_images = [];

  void initState() {
    cityApi(widget.app_name);
    super.initState();
  }

  cityApi(String app_name) async {
    String url =
        "https://api.pexels.com/v1/search?query=$app_name&per_page=100";

    await http.get(Uri.parse(url), headers: {
      "Authorization":
          'bRCnV0vbMsyvn4xxAyxATa2BbzhezlaL5b257BdObLVGMxqZsnZZAZVe'
    }).then((value) {
      print(value.body);
      Map result = jsonDecode(value.body);

      setState(() {
        city_images = result['photos'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: GridView.builder(
              itemCount: city_images.length,
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
                                  imageUrl: city_images[index]['src']
                                      ['large2x'],
                                )));
                  },
                  child: Container(
                    color: Colors.black,
                    child: Image.network(
                      city_images[index]['src']['tiny'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
