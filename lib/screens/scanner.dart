import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_generator_and_reader/theme/custom_theme.dart' as style;

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  ScanResult scanResult;
  String qrResult = "";
  void scanCode() async {
    try {
      var options = ScanOptions(

          android: AndroidOptions(useAutoFocus: true),
          autoEnableFlash: false,
          useCamera: -1);
      var codeResult = await BarcodeScanner.scan(options: options);
      setState(() {
        if(codeResult.rawContent.isEmpty){
          qrResult = "Failed to Scan Try Again";
        }
        else{
          qrResult = codeResult.rawContent;
        }
      });

    } catch(e) {
    print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: Scaffold(
              backgroundColor: style.CustomTheme.backgroundColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    child: Text(
                      "QR Code Scan \n Result",
                      style: style.CustomTheme.header,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Expanded(
                          child: Text(
                            qrResult,
                            style: style.CustomTheme.text1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(15.0),
                        onPressed: scanCode,
                        child: Container(
                          width: 200,
                          child: Text(
                            "Scan",
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
          );
  }

}
