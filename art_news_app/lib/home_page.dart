import 'package:art_news_app/models/art.dart';
import 'package:flutter/material.dart';
import 'package:art_news_app/database/db_helper.dart';
import 'package:art_news_app/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(""),
                  Image.asset(
                    "assets/arts_nine.jpg",
                    width: 100,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Arts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              FutureBuilder<List<Art>>(
                future: DBHelper.getArts().then((maps) {
                  return List.generate(maps.length, (i) {
                    return Art(
                      id: maps[i][''],
                      name: maps[i]['name'],
                      image: maps[i]['image'],
                      description: maps[i]['description'],
                      rate: maps[i]['rate'],
                      page: maps[i]['page'],
                      categoryArt: maps[i]['categoryArt'],
                      language: maps[i]['language'],
                    );
                  });
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Art> arts = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: arts.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final art = arts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(art: art),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 90,
                            padding: EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  art.image,
                                  width: 64,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(art.name),
                                    Text(art.categoryArt),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
