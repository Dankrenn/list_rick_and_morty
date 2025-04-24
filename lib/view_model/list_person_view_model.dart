import 'package:flutter/cupertino.dart';
import 'package:list_rick_and_morty/model/person.dart';
import 'package:list_rick_and_morty/services/hive_service.dart';
import 'package:list_rick_and_morty/services/network_service.dart';

class ListPersonViewModel extends ChangeNotifier {
  late List<Person> _persons;
  late List<Person> _personsFavorite;
  final HiveService _hiveService;
  final NetworkService _networkService = NetworkService();
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _isLoadingInitial = true;
  String _searchQuery = '';

  List<Person> get personsFavorite => _personsFavorite;
  List<Person> get persons => _persons;
  bool get isLoadingMore => _isLoadingMore;
  bool get isLoadingInitial => _isLoadingInitial;

  ListPersonViewModel(this._hiveService) {
    _loadInitialCharacters();
    _loadFavoritesFromHive();
  }

  Future<void> _loadInitialCharacters() async {
    _isLoadingInitial = true;
    notifyListeners();

    _persons = await _networkService.fetchCharacters(_currentPage);
    _updateFavoritesStatus();

    _isLoadingInitial = false;
    notifyListeners();
  }

  Future<void> loadMoreCharacters() async {
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    _currentPage++;
    final newCharacters = await _networkService.fetchCharacters(_currentPage);
    _persons.addAll(newCharacters);
    _updateFavoritesStatus();

    _isLoadingMore = false;
    notifyListeners();
  }

  void _loadFavoritesFromHive() {
    _personsFavorite = _hiveService.getFavorites();
    notifyListeners();
  }

  void _updateFavoritesStatus() {
    for (var person in _persons) {
      if (_personsFavorite.any((fav) => fav.id == person.id)) {
        person.isFavorite = true;
      }
    }
  }

  Future<void> toggleFavorite(int personId) async {
    final person = _persons.firstWhere((p) => p.id == personId);
    person.isFavorite = !person.isFavorite;

    if (person.isFavorite) {
      _personsFavorite.add(person);
      await _hiveService.addFavorite(person);
    } else {
      _personsFavorite.remove(person);
      await _hiveService.removeFavorite(personId);
    }
    _loadFavoritesFromHive();
    notifyListeners();
  }

  void filterPersons(String query) {
    _searchQuery = query.toLowerCase();

    if (_searchQuery.isEmpty) {
      _loadFavoritesFromHive();
    } else {
      _personsFavorite = _personsFavorite
          .where((person) => person.name.toLowerCase().contains(_searchQuery))
          .toList();
    }
    notifyListeners();
  }
}
