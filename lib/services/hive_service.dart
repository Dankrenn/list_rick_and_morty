import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_rick_and_morty/model/person.dart';

class HiveService {
  static const String _themeBox = 'ThemeBox';
  static const String _themeKey = 'ThemeBox';
  static const String _favoriteBoxName = 'favoriteBox';
  late Box<Person> _favoriteBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PersonAdapter());
    _favoriteBox = await Hive.openBox<Person>(_favoriteBoxName);
  }

  Future<void> setIsDarkMode(bool isDarkMode) async {
    var box = await Hive.openBox(_themeBox);
    await box.put(_themeKey, isDarkMode);
  }

  Future<bool> getIsDarkMode() async {
    var box = await Hive.openBox(_themeBox);
    return await box.get(_themeKey, defaultValue: false);
  }

  Future<void> addFavorite(Person person) async {
    await _favoriteBox.put(person.id, person);
  }

  Future<void> removeFavorite(int personId) async {
    await _favoriteBox.delete(personId);
  }

  List<Person> getFavorites() {
    return _favoriteBox.values.toList();
  }
}
