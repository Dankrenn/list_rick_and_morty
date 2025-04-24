import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/model/person.dart';
import 'package:list_rick_and_morty/view_model/list_person_view_model.dart';
import 'package:provider/provider.dart';

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ListPersonViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    person.image,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    person.isFavorite ? Icons.star : Icons.star_border,
                  ),
                  onPressed: () {
                    model.toggleFavorite(person.id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Статус: ${person.status}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Гендер: ${person.gender}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Количество эпизодов: ${person.episode.length}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}