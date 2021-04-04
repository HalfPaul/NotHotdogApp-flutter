import 'package:flutter/material.dart';
import 'answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'SEAFOOD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
            flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: Stack(
            children: <Widget>[
              Center(
                  child: Text(
                'SEEFOOD',
                style: TextStyle(
                  fontSize: 65,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.black,
                ),
              )),
              Center(
                  child: Text(
                'SEEFOOD',
                style: TextStyle(
                  fontSize: 65,
                  color: Colors.white,
                ),
              )),
            ],
          ),
        )),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: const Text('"The Shazam for food"',
                  style: TextStyle(fontSize: 30, color: Colors.pink))),
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/first.jpg"),
                      fit: BoxFit.fitWidth)),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 5),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/second.jpg"),
                    fit: BoxFit.fitWidth)),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3.8,
          ),
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/third.jpg"),
                      fit: BoxFit.fitWidth)),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: new Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red.shade900,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnswerPage()),
                        );
                      },
                    )),
                const Text(
                  "Touch to SEEFOOD",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ])),
        ],
      ),
    );
  }
}
