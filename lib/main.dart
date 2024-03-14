import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpepar/categaries.dart';
import 'package:wallpepar/categaries_modul.dart';
import 'package:wallpepar/full.dart';
import 'package:wallpepar/search.dart';

import 'city.dart';
import 'widget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyMeterialApp());
}

class MyMeterialApp extends StatelessWidget {
  const MyMeterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Myapp());
  }
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List categaries = [];
  List image = [];
  int page = 1;

  void initState() {
    categaries = getCategaries();
    fetchApi();
    super.initState();
  }

  fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          'Authorization':
              'bRCnV0vbMsyvn4xxAyxATa2BbzhezlaL5b257BdObLVGMxqZsnZZAZVe'
        }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        image = result['photos'];
      });
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        "https://api.pexels.com/v1/curated?per_page=80&page=" + page.toString();
    await http.get(Uri.parse(url), headers: {
      "Authorization":
          'bRCnV0vbMsyvn4xxAyxATa2BbzhezlaL5b257BdObLVGMxqZsnZZAZVe'
    }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        image.addAll(result['photos']);
      });
    });
  }

  final mycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: TextButton(
            onPressed: () {},
            child: Icon(
              Icons.menu,
              color: Colors.amber,
            ),
          ),
          title: app_name(),
          actions: [
            TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.face,
                  color: Colors.amber,
                ))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(4, 4),
                            color: Colors.grey)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: mycontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search"),
                        )),
                        InkWell(
                          child: Icon(Icons.search),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        search(text: mycontroller.text)));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    //  padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemCount: categaries.length,
                    shrinkWrap: true,
                    itemBuilder: (context, intex) {
                      return categaries_tail(
                          app_name: categaries[intex].name,
                          image_url: categaries[intex].image_url);
                    }),
              ),
              Expanded(
                flex: 5,
                child: GridView.builder(
                    itemCount: image.length,
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
                                        imageUrl: image[index]['src']
                                            ['large2x'],
                                      )));
                        },
                        child: Container(
                          color: Colors.black,
                          child: Image.network(
                            image[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
              TextButton(
                  onPressed: () {
                    loadMore();
                  },
                  child: Text("Load"))
            ],
          ),
        ));
  }
}

class categaries_tail extends StatelessWidget {
  final String app_name, image_url;

  categaries_tail({required this.app_name, required this.image_url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => city(app_name: app_name)));
      },
      child: Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
                width: 150,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      app_name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          wordSpacing: 5.0),
                    )),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                          color: Colors.grey)
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          image_url,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
