import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/view/help_widgets/list_person.dart';
import 'package:list_rick_and_morty/view_model/list_person_view_model.dart';
import 'package:provider/provider.dart';

class ListPersonView extends StatelessWidget {
  const ListPersonView({super.key});

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
        title: const Text("Персонажи"),
        centerTitle: true,
      ),
      body: Consumer<ListPersonViewModel>(
        builder: (context, model, child) {
          if (model.isLoadingInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListPerson(
              isFavorite: false,
              scrollController: scrollController,
              isLoadingMore: model.isLoadingMore,
            ),
          );
        },
      ),
    );
  }
}
