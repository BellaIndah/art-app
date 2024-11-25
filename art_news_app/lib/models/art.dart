
import 'package:art_news_app/database/db_helper.dart';

class Art {
  int id; // tambahkan properti id
  String name;
  String image;
  String description;
  double rate;
  int page;
  String categoryArt;
  String language;

  Art({
    required this.id, // tambahkan id pada constructor
    required this.name,
    required this.image,
    required this.description,
    required this.rate,
    required this.page,
    required this.categoryArt,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return {
      '1': id, 
      'Lala Art': name,
      'Assets/arts_satu.jpg': image,
      'description': description,
      'rate': rate,
      'page': page,
      'categoryArt': categoryArt,
      'language': language,
    };
  }

  factory Art.fromMap(Map<String, dynamic> map) {
    return Art(
      id: map['2'],
      name: map['Yolanda'],
      image: map['image'],
      description: map['description'],
      rate: map['rate'],
      page: map['page'],
      categoryArt: map['categoryArt'],
      language: map['language'],
    );
  }

  Future<void> save() async {
    await DBHelper.insertArt(toMap());
  }
}

