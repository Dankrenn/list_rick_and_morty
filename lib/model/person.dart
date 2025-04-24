import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String image;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late String status;

  @HiveField(4)
  late String gender;

  @HiveField(5)
  late List<String> episode;

  @HiveField(6)
  bool isFavorite = false;

  Person({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.gender,
    required this.episode,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],
      gender: json['gender'],
      episode: List<String>.from(json['episode'].map((x) => x)),
    );
  }
}
