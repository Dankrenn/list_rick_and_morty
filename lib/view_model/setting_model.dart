import 'package:flutter/material.dart';
import 'package:list_rick_and_morty/services/hive_service.dart';


class SettingModel extends ChangeNotifier{
  HiveService hiveService = HiveService();
  late bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  SettingModel() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await hiveService.getIsDarkMode();
    notifyListeners();
  }

  Future<void> updateTheme() async {
    _isDarkMode = !_isDarkMode;
    await hiveService.setIsDarkMode(_isDarkMode);
    notifyListeners();
  }

  ThemeData get theme => _isDarkMode ? ThemeData.dark() : ThemeData.light();
}