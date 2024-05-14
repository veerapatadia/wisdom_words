import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wisdomwords/utils/global.dart';

class detail_page extends StatefulWidget {
  const detail_page({super.key});

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  bool isGridView = false;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${data['categoryName']}",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Random random = Random();
          //       int num = random.nextInt(quoteData.allQuotesData.length);
          //
          //       showDialog(
          //         context: (context),
          //         builder: (context) {
          //           return AlertDialog(
          //             title: Text("Quote"),
          //             // content: Text(
          //             //     "${quoteData.allQuotesData[num]['categoryQuote'].quote}"),
          //           );
          //         },
          //       );
          //     },
          // icon: Icon(Icons.question_mark)),
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: (isGridView) ? Icon(Icons.list) : Icon(Icons.grid_view),
          )
        ],
      ),
      body: (isGridView)
          ? GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 2,
              ),
              children: List.generate(data['categoryQuotes'].length, (index) {
                var e = data['categoryQuotes'][index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red,
                      image: DecorationImage(
                        image: NetworkImage("${e['image']}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 185,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.format_quote,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${e['quote']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${e['author']}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...data['categoryQuotes']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                height: 580,
                                width: 380,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${e['image']}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 295,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.format_quote,
                                                  color: Colors.white,
                                                  size: 60,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${e['quote']}",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${e['author']}",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 100,
                                                top: 10,
                                                left: 100,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        quoteData.favData
                                                            .add(e);
                                                        quoteData.favQuoteData
                                                            .add(e);
                                                        quoteData.convertData();
                                                        e['like'] = !e['like'];
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 47,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: Icon(
                                                        e['like']
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: e['like']
                                                            ? Colors.red
                                                            : Colors.black,
                                                        size: 27,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        quoteData.editData
                                                            .add(e);
                                                        quoteData.allEditData
                                                            .add(e);
                                                        quoteData
                                                            .convertEditData();
                                                        e['edit'] = !e['edit'];
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 47,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            quoteData.editData
                                                                .add(e);
                                                            quoteData
                                                                .allEditData
                                                                .add(e);
                                                            quoteData
                                                                .convertEditData();
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    'edit_page',
                                                                    arguments:
                                                                        e);
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 27,
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
