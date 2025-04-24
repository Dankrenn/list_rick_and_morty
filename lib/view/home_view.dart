import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: model.tabs[model.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentIndex,
        onTap:(index) => model.updateCurrentIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.star),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_sharp),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: '',),
        ],
      ),
    );
  }
}
