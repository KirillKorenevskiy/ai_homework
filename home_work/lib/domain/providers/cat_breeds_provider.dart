import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/services/cat_breed_service.dart';
import 'models/cat_breed.dart';

class CatBreedsProvider with ChangeNotifier {
  final CatBreedService _service;

  List<CatBreed> _breeds = [];
  List<CatBreed> _filteredBreeds = [];
  CatBreed? _selectedBreed;
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  bool _hasMore = true;
  final int _perPage = 10;
  String _searchQuery = '';
  bool _sortAscending = true;
  Timer? _debounce;

  CatBreedsProvider(this._service);

  List<CatBreed> get breeds => _filteredBreeds;
  List<CatBreed> get allBreeds => _breeds;
  CatBreed? get selectedBreed => _selectedBreed;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get hasMore => _hasMore;

  void _filterAndSortBreeds() {
    // Filter
    _filteredBreeds = _breeds.where((breed) {
      final query = _searchQuery.toLowerCase();
      return breed.name.toLowerCase().contains(query) ||
          (breed.temperament?.toLowerCase().contains(query) ?? false) ||
          (breed.origin?.toLowerCase().contains(query) ?? false);
    }).toList();

    // Sort
    _filteredBreeds.sort((a, b) {
      final compare = a.name.compareTo(b.name);
      return _sortAscending ? compare : -compare;
    });

    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _filterAndSortBreeds();
    });
  }

  void toggleSortOrder() {
    _sortAscending = !_sortAscending;
    _filterAndSortBreeds();
  }

  bool get isSortedAscending => _sortAscending;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> loadBreeds({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _breeds = [];
    }

    if (!_hasMore) return;

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final newBreeds = await _service.getBreeds();
      if (newBreeds.isEmpty) {
        _hasMore = false;
      } else {
        if (refresh) {
          _breeds = newBreeds;
        } else {
          _breeds.addAll(newBreeds);
        }
        _currentPage++;
        _filterAndSortBreeds();
      }
      _error = '';
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadBreedDetails(String breedId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _selectedBreed = await _service.getBreedDetails(breedId);
      _error = '';
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  void clearSelectedBreed() {
    _selectedBreed = null;
    notifyListeners();
  }
}
