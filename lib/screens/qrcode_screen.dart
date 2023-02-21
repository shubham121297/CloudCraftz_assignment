import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_generator/models/details.dart';
import '../models/details.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import 'package:image_picker/image_picker.dart';

class QRCodeScreen extends StatefulWidget {
  var cardDetails = Details(
      company: "",
      designation: "",
      firstName: "",
      lastName: "",
      workEmail: "",
      workPhone: "");

  QRCodeScreen({Key? mykey, required this.cardDetails}) : super(key: mykey);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> _downloadPNG() async {
    final qrValidationResult = QrValidator.validate(
      data:
          "First Name : ${widget.cardDetails.firstName}, Last Name : ${widget.cardDetails.lastName}, Work Phone : ${widget.cardDetails.workPhone}, Work Email : ${widget.cardDetails.workEmail},Designation : ${widget.cardDetails.designation}, Company : ${widget.cardDetails.company}",
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;
    print(qrCode);

    final painter = QrPainter.withQr(
      qr: qrCode!,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // String filePath = '${appDocDir.path}/file.txt';

    // new File(filePath).readAsString().then((String contents) {
    //   print(contents);
    //});
    final picData =
        await painter.toImageData(2048, format: ImageByteFormat.png);
    await writeToFile(picData!, path);

    // await Share.shareFiles(
    //     [filePath],
    //     mimeTypes: ["image/png"],
    //     subject: 'My QR code',
    //     text: 'Please scan me');
    // print(path);
    try {
      print(path);
      final success = await GallerySaver.saveImage(path);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: success!
            ? Text('Image saved to Gallery')
            : Text('Error saving image'),
      ));
    } catch (e) {
      print('ErrorWhileSavingImage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Image.network(
                'https://www.cloudcraftz.com/wp-content/uploads/2020/12/Cloudcraftz_logo-e1608656227668.png',
                height: 70,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 5, color: Colors.lightBlue)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your QR  code is generated',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: QrImage(
                        data:
                            "First Name : ${widget.cardDetails.firstName}, Last Name : ${widget.cardDetails.lastName}, Work Phone : ${widget.cardDetails.workPhone}, Work Email : ${widget.cardDetails.workEmail},Designation : ${widget.cardDetails.designation}, Company : ${widget.cardDetails.company}",
                        version: QrVersions.auto,
                        size: 250.0,
                        errorCorrectionLevel: QrErrorCorrectLevel.H,
                      ),
                    ),
                    Text(
                      'Best wishes from',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Image.network(
                      'https://www.cloudcraftz.com/wp-content/uploads/2020/12/Cloudcraftz_logo-e1608656227668.png',
                      height: 25,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.refresh,
                              size: 20,
                            ),
                            Text(
                              'Restart',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          //minimumSize: Size.fromHeight(50),
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _downloadPNG,
                        // final qrValidationResult = QrValidator.validate(
                        //   data:
                        //       "First Name : ${widget.cardDetails.firstName}, Last Name : ${widget.cardDetails.lastName}, Work Phone : ${widget.cardDetails.workPhone}, Work Email : ${widget.cardDetails.workEmail},Designation : ${widget.cardDetails.designation}, Company : ${widget.cardDetails.company}",
                        //   version: QrVersions.auto,
                        //   errorCorrectionLevel: QrErrorCorrectLevel.L,
                        // );
                        // final qrCode = qrValidationResult.qrCode;

                        // final painter = QrPainter.withQr(
                        //   qr: qrCode!,
                        //   color: const Color(0xFF000000),
                        //   gapless: true,
                        //   embeddedImageStyle: null,
                        //   embeddedImage: null,
                        // );

                        // Directory tempDir = await getTemporaryDirectory();
                        // String tempPath = tempDir.path;
                        // final ts = DateTime.now().millisecondsSinceEpoch.toString();
                        // String path = '$tempPath/$ts.png';

                        child: Text(
                          'Download',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
