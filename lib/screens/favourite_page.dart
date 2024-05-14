import 'package:flutter/material.dart';
import 'package:wisdomwords/utils/global.dart';

class favourite_Page extends StatefulWidget {
  const favourite_Page({super.key});

  @override
  State<favourite_Page> createState() => _favourite_PageState();
}

class _favourite_PageState extends State<favourite_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Page",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ...quoteData.favQuoteData.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                height: 580,
                                width: 379,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                quoteData.favQuoteData
                                                    .remove(e);
                                                quoteData.favData.remove(e);
                                                e['like'] = !e['like'];
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 27,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 380,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${e['quote']}",
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${e['author']}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
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
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
