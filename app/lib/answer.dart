import 'dart:io';
import 'package:mlapp/classifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlapp/loading.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final Classifier classifier = Classifier();
  final picker = ImagePicker();
  var _image;
  var _answer;

  Future predictImage() async {
    var image;
    image = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 224,
        maxWidth: 224,
        imageQuality: 100);
    final answer = await classifier.classifyImage(image);
    setState(() {
      _answer = answer;
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    predictImage();
  }

  @override
  Widget build(BuildContext context) {
    if (_answer == "Hotdog") {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(_image.path)), fit: BoxFit.cover)),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.fromLTRB(
                0, 0, 0, MediaQuery.of(context).size.height - 310),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.done,
                  size: 120,
                )),
          )),
          Positioned(
              child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                color: Colors.green,
                child: Center(
                    child: Text(
                  _answer,
                  style: TextStyle(fontSize: 50, color: Colors.white),
                )),
                width: MediaQuery.of(context).size.width,
                height: 120),
          ))
        ]),
      );
    } else if (_answer == "Not Hotdog") {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(_image.path)), fit: BoxFit.cover)),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height - 310, 0, 0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 120,
                )),
          )),
          Positioned(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                color: Colors.red,
                child: Center(
                    child: Text(
                  _answer,
                  style: TextStyle(fontSize: 50, color: Colors.white),
                )),
                width: MediaQuery.of(context).size.width,
                height: 120),
          ))
        ]),
      );
    }
    return LoadingScreen();
  }
}
