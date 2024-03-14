import 'package:flutter/material.dart';
import 'package:wallpepar/main.dart';

class full extends StatefulWidget {
  final String imageUrl;

  const full({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<full> createState() => _fullState();
}

class _fullState extends State<full> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Myapp()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
