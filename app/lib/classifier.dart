import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier {
  Classifier();

  classifyImage(var image) async {
    var inputImage = File(image.path);

    ImageProcessor imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(224, 224, ResizeMethod.BILINEAR))
        .add(NormalizeOp(0, 255))
        .build();

    TensorImage tensorImage = TensorImage.fromFile(inputImage);
    tensorImage = imageProcessor.process(tensorImage);
    TensorBuffer probabilityBuffer =
        TensorBuffer.createFixedSize(<int>[1, 2], TfLiteType.float32);

    try {
      Interpreter interpreter = await Interpreter.fromAsset("model.tflite");
      interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);
    } catch (e) {
      print(e);
    }
    List<String> labels = await FileUtil.loadLabels("labels/labels.txt");
    TensorProcessor probabilityProccessor = TensorProcessorBuilder().build();
    TensorLabel tensorLabel = TensorLabel.fromList(
        labels, probabilityProccessor.process(probabilityBuffer));

    Map labeledProb = tensorLabel.getMapWithFloatValue();
    double highestProb = 0;
    String answer;

    labeledProb.forEach((prediction, probability) {
      if (probability * 100 > highestProb) {
        highestProb = probability * 100;
        answer = prediction;
      }
    });
    return answer;
  }
}
