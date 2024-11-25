import 'dart:ui';

import 'package:art_news_app/database/db_helper.dart';
import 'package:art_news_app/models/art.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Art art;
  const DetailPage({Key? key, required this.art}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(art.name),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: DBHelper.getArt(art.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic>? fetchedArt = snapshot.data;
            if (fetchedArt != null) {
              return ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(fetchedArt['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Center(
                        child: Image.asset(
                          fetchedArt['image'],
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        fetchedArt['name'],
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      bookInfo(fetchedArt['rate'].toString(), "Rating"),
                      bookInfo(fetchedArt['page'].toString(), "Page"),
                      bookInfo(fetchedArt['language'], "Language"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Deskripsi",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: artDesc(fetchedArt['description']),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Art not found'));
            }
          }
        },
      ),
    );
  }

  Widget bookInfo(String value, String info) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          info,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget artDesc(String description) {
    return Column(
      children: [
        Text(
          description,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
