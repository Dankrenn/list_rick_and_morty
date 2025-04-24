import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/view/is_favorite_list_person_view.dart';
import 'package:list_rick_and_morty/view/list_person_view.dart';
import 'package:list_rick_and_morty/view/setting_view.dart';

class HomeViewModel extends ChangeNotifier{
  int _currentIndex = 1;
  final List<Widget> _tabs = [
    IsFavoriteListPersonView(),
    ListPersonView(),
    SettingsView(),
  ];

  int get currentIndex => _currentIndex;
  List<Widget> get tabs => _tabs;


  void updateCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}