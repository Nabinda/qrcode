import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_generator_and_reader/theme/custom_theme.dart' as style;

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  GlobalKey globalKey = new GlobalKey();
  final _form = GlobalKey<FormState>();
  String inputText;
  bool isQRGenerated = false;
  void validate() {
    _form.currentState.save();
    generateCode();
  }

  Future<void> _share() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

     // Directory tempDir = await getApplicationDocumentsDirectory();
      //String appDocPath = tempDir.path;
      //final file = await new File('$appDocPath/$inputText.png').create();
      //await file.writeAsBytes(pngBytes);
      final channel = const MethodChannel('channel:me.psykho.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

  void generateCode() async {
    if (inputText.isEmpty) {
      setState(() {
        inputText = "https://github.com/Nabinda";
        isQRGenerated = true;
      });
    } else {
      setState(() {
        isQRGenerated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: style.CustomTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  child: Text(
                    "Generate \n QR Code ",
                    style: style.CustomTheme.header,
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    isQRGenerated
                        ? Column(
                            children: [
                              RepaintBoundary(
                                key: globalKey,
                                child: QrImage(
                                  backgroundColor: Colors.white,
                                  data: inputText,
                                  foregroundColor: Colors.black,
                                  version: QrVersions.auto,
                                  size: 200,
                                  gapless: false,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              FlatButton(
                                padding: EdgeInsets.all(15.0),
                                onPressed: _share,
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Share",
                                    style: style.CustomTheme.text1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.blue, width: 3.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                              )
                            ],
                          )
                        : Container(),
                    Form(
                      key: _form,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                            labelText: "Text",
                          ),
                          validator: (value) {
                            if (value.trim() == null) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            inputText = value;
                          },
                          style: style.CustomTheme.text1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(15.0),
                      onPressed: validate,
                      child: Container(
                        width: 200,
                        child: Text(
                          "Generate",
                          style: style.CustomTheme.text1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                    )
                  ],
                ),
                Container(
                  child: Text(""),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
