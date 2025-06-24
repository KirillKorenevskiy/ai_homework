import 'package:flutter/material.dart';

import '../../data/services/cat_fact_service.dart';
import 'models/cat_fact.dart';

class CatFactsProvider with ChangeNotifier {
  final CatFactService _service;

  List<CatFact> _facts = [];
  CatFact? _randomFact;
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  bool _hasMore = true;

  CatFactsProvider(this._service);

  List<CatFact> get facts => _facts;
  CatFact? get randomFact => _randomFact;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get hasMore => _hasMore;

  Future<void> loadFacts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _facts = [];
    }

    if (!_hasMore) return;

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final newFacts = await _service.getFacts(limit: 10);
      if (newFacts.isEmpty) {
        _hasMore = false;
      } else {
        if (refresh) {
          _facts = newFacts;
        } else {
          _facts.addAll(newFacts);
        }
        _currentPage++;
      }
      _error = '';
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadRandomFact() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _randomFact = await _service.getRandomFact();
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

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
