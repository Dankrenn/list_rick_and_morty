import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/view/help_widgets/person_card.dart';
import 'package:list_rick_and_morty/view_model/list_person_view_model.dart';
import 'package:provider/provider.dart';

class ListPerson extends StatelessWidget {
  final bool isFavorite;
  final ScrollController scrollController;
  final bool isLoadingMore;

  ListPerson({
    super.key,
    required this.isFavorite,
    required this.scrollController,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ListPersonViewModel>(context);
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(15.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: isFavorite ? model.personsFavorite.length : model.persons.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= model.persons.length) {
          return Center(child: CircularProgressIndicator());
        }
        if (!isFavorite) {
          return PersonCard(person: model.persons[index]);
        } else {
          return PersonCard(person: model.personsFavorite[index]);
        }
      },
    );
  }
}
