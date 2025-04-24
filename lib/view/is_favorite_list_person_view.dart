import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/view/help_widgets/list_person.dart';
import 'package:list_rick_and_morty/view_model/list_person_view_model.dart';
import 'package:provider/provider.dart';

class IsFavoriteListPersonView extends StatelessWidget {
  const IsFavoriteListPersonView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ListPersonViewModel>(context);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        model.loadMoreCharacters();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Избранные персонажи"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Поиск по имени',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                model.filterPersons(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<ListPersonViewModel>(
              builder: (context, model, child) {
                if (model.isLoadingInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListPerson(
                    isFavorite: true,
                    scrollController: scrollController,
                    isLoadingMore: model.isLoadingMore,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
