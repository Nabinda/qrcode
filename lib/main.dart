import 'package:flutter/material.dart';
import 'package:qrcode_generator_and_reader/screens/generator.dart';
import 'package:qrcode_generator_and_reader/screens/scanner.dart';
import 'theme/custom_theme.dart' as style;

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QRCode Scanner and Generator",
      home: HomePage(),
      routes: {
        "/scan":(ctx)=>Scan(),
        "/generate":(ctx)=>Generate(),
      },
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isNormal = true;
  void changeTheme() {
    setState(() {
      isNormal = !isNormal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          backgroundColor: style.CustomTheme.backgroundColor,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    child: Text(
                      "QR Code Scanner \n and Generator",
                      style: style.CustomTheme.header,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        flatButton("Scan QR", Scan()),
                        SizedBox(
                          height: 10,
                        ),
                        flatButton("Generate QR", Generate()),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(""),
                  )
                ],
              ),
              Positioned(
                top: 20,
                right: 10,
                child: IconButton(
                  onPressed: changeTheme,
                  icon: Icon(
                    isNormal ? Icons.lightbulb_outline : Icons.highlight,
                    size: 30,
                    color: isNormal ? Colors.black : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget flatButton(String text, Widget route) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: ()  {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => route));
      },
      child: Container(
        width: 200,
        child: Text(
          text,
          style: style.CustomTheme.text1,
          textAlign: TextAlign.center,
        ),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue, width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
