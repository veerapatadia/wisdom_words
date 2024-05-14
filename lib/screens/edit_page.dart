import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:wisdomwords/utils/global.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Color selBackGroundColor = Colors.black87;
  Color selFontColor = Colors.white;

  List<String> fontFamilies = GoogleFonts.asMap().keys.toList();

  double textSize = 18;
  FontWeight fontWeight = FontWeight.w500;
  double font = 5;
  late String selFont;
  String? selImage;

  double dx = 0;
  double dy = 0;

  GlobalKey repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selFont = fontFamilies[0];
  }

  Future<void> shareImage() async {
    RenderRepaintBoundary renderRepaintBoundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    Uint8List fetchImage = byteData!.buffer.asUint8List();

    Directory directory = await getApplicationCacheDirectory();

    String path = directory.path;

    File file = File('$path.png');

    file.writeAsBytes(fetchImage);

    ShareExtend.share(file.path, "Image");
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> edit =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Quote",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                selBackGroundColor = Colors.black87;
                selFontColor = Colors.white;
                textSize = 18;
                fontWeight = FontWeight.w500;
                font = 5;
                selFont = fontFamilies[0];
                selImage = null;
              });
            },
            icon: const Icon(Icons.restart_alt),
          ),
          // IconButton(
          //   onPressed: () async {
          //     await FlutterClipboard.copy(quote.quote).then((value) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(
          //           backgroundColor: Colors.green,
          //           behavior: SnackBarBehavior.floating,
          //           content: Text("Copied Success!!!"),
          //         ),
          //       );
          //     });
          //   },
          //   icon: const Icon(Icons.copy_all),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await shareImage();
        },
        child: const Icon(Icons.share),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Slider(
                        value: dx,
                        min: -0.95,
                        max: 0.95,
                        onChanged: (val) {
                          setState(() {
                            dx = val;
                          });
                        }),
                    Slider(
                        value: dy,
                        min: -0.95,
                        max: 0.95,
                        onChanged: (val) {
                          setState(() {
                            dy = val;
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: quoteData.allEditData.map((edit) {
                        return RepaintBoundary(
                          key: repaintKey,
                          child: Stack(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 350,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      image: (selImage != null)
                                          ? DecorationImage(
                                              image: NetworkImage(selImage!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  Container(
                                    height: 350,
                                    width: 350,
                                    alignment: Alignment(dx, dy),
                                    decoration: BoxDecoration(
                                      color: Colors.black87.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.asset(
                                      "assets/img/diwali-lamp.png",
                                      height: 40,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 350,
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: (selImage == null)
                                      ? selBackGroundColor
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 195),
                                      Text(
                                        "${edit['quote']}",
                                        style: GoogleFonts.getFont(
                                          selFont,
                                          textStyle: TextStyle(
                                              fontSize: textSize,
                                              fontWeight: fontWeight,
                                              color: selFontColor),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${edit['author']}",
                                            style: GoogleFonts.getFont(
                                              selFont,
                                              textStyle: TextStyle(
                                                  fontSize: textSize,
                                                  fontWeight: fontWeight,
                                                  color: selFontColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView(
                  children: [
                    Slider(
                      value: font,
                      min: 1,
                      max: 9,
                      divisions: 9,
                      onChanged: (val) {
                        setState(() {
                          if (val == 1) {
                            font = val;
                            fontWeight = FontWeight.w100;
                          } else if (val <= 2) {
                            font = val;
                            fontWeight = FontWeight.w200;
                          } else if (val <= 3) {
                            font = val;
                            fontWeight = FontWeight.w300;
                          } else if (val <= 4) {
                            font = val;
                            fontWeight = FontWeight.w400;
                          } else if (val <= 5) {
                            font = val;
                            fontWeight = FontWeight.w500;
                          } else if (val <= 6) {
                            font = val;
                            fontWeight = FontWeight.w600;
                          } else if (val <= 7) {
                            font = val;
                            fontWeight = FontWeight.w700;
                          } else if (val <= 8) {
                            font = val;
                            fontWeight = FontWeight.w800;
                          } else if (val == 9) {
                            font = val;
                            fontWeight = FontWeight.w900;
                          }
                        });
                      },
                    ),
                    Slider(
                      value: textSize,
                      min: 15,
                      max: 22,
                      onChanged: (val) {
                        setState(() {
                          textSize = val;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Change Font Color",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Colors.primaries
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selFontColor = e;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: e,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black87,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Change Font",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: fontFamilies
                                .map((e) => (fontFamilies.indexOf(e) <= 10)
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selFont = e;
                                            print(e);
                                            print(selFont);
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 10),
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black87,
                                              width: 3,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aa",
                                            style: GoogleFonts.getFont(
                                              e,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container())
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Change BackGround Color",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Colors.primaries
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selImage = null;
                                          selBackGroundColor = e;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: e,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black87,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Change BackGround Image",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: allImageData
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selImage = e['image-url'];
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(e['image-url']),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black87,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
